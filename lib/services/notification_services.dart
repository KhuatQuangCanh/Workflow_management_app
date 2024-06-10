import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:workflow_management_app/common/widgets/notified/notified_page.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/models/personal_task.dart';

class NotifyHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    _configureLocalTimeZone();
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('appicon');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,

    );

    // Tạo kênh thông báo
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id', // ID kênh thông báo
      'Channel Name', // Tên kênh thông báo
       // Mô tả kênh thông báo
      importance: Importance.max, // Mức độ quan trọng của kênh thông báo
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Hủy bỏ tất cả các thông báo hiện tại (chạy một lần khi khởi tạo ứng dụng)

  }

  Future<void> displayNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',

      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  Future<void> scheduledNotification(
      int hour, int minutes, PersonalTask task) async {
    final String timeZone = 'Asia/Ho_Chi_Minh';
    final tz.Location location = tz.getLocation(timeZone);

    final tz.TZDateTime scheduleDate = _convertTime(hour, minutes, location);

    // Chỉ lên lịch thông báo nếu thời gian thông báo là trong tương lai
    if (scheduleDate.isAfter(tz.TZDateTime.now(location))) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title,
        task.note,
        scheduleDate,
        const NotificationDetails(
          android: AndroidNotificationDetails('your_channel_id', 'your_channel_name'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|${task.note}|",
      );
    }
  }

  tz.TZDateTime _convertTime(int hour, int minutes, tz.Location location) {
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(location, now.year, now.month, now.day, hour, minutes);
    // if (scheduleDate.isBefore(now)) {
    //   scheduleDate = scheduleDate.add(const Duration(days: 1));
    // }
    return scheduleDate;
  }

  void _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future<void> onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    Get.to(() => NotifiedPage(label: payload));
  }


}
