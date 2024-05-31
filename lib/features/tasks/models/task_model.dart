import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String groupId;
  final List<String> assigneeIds; // Danh sách người tham gia task
  final DateTime startTime; // Thời gian bắt đầu của task
  final DateTime endTime; // Thời gian kết thúc của task
  final bool isCompleted; // Trạng thái hoàn thành của task
  final int notificationMinutesBefore; // Thông báo trước bao nhiêu phút

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.groupId,
    required this.assigneeIds,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
    required this.notificationMinutesBefore,
  });

  static TaskModel empty() => TaskModel(
    id: '',
    title: '',
    description: '',
    groupId: '',
    assigneeIds: [],
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    isCompleted: false,
    notificationMinutesBefore: 5,
  );

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Description': description,
      'GroupId': groupId,
      'AssigneeIds': assigneeIds,
      'StartTime': startTime.toIso8601String(),
      'EndTime': endTime.toIso8601String(),
      'IsCompleted': isCompleted,
      'NotificationMinutesBefore': notificationMinutesBefore,
    };
  }

  factory TaskModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? {};
    return TaskModel(
      id: document.id,
      title: data["Title"] ?? '',
      description: data["Description"] ?? '',
      groupId: data["GroupId"] ?? '',
      assigneeIds: List<String>.from(data["AssigneeIds"] ?? []),
      startTime: DateTime.parse(data["StartTime"] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(data["EndTime"] ?? DateTime.now().toIso8601String()),
      isCompleted: data["IsCompleted"] ?? false,
      notificationMinutesBefore: data["NotificationMinutesBefore"] ?? 0,
    );
  }
}
