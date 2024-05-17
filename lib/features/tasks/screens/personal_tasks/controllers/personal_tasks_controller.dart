
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/db/db_helper.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';

import '../models/task.dart';

class PersonalTasksController extends GetxController {
  static PersonalTasksController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    DBHelper.initDb().then((_) {
      getTasks();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  bool disableDate(DateTime day) {
    if((day.isAfter(DateTime.now().subtract(Duration(days: 1))) && day.isBefore(DateTime.now().add(Duration(days: 5))))){
      return true;
    }
    return false;
  }


  var selectedDate = DateTime.now().obs;


  getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value
      ,firstDate: DateTime.now(), lastDate: DateTime(2025),
      // initialEntryMode: DatePickerEntryMode.input,
      //   initialDatePickerMode: DatePickerMode.year,
      fieldHintText: 'Date/Month/Year',
    );
    if(pickedDate != null && pickedDate!=selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }


  var startTime = DateFormat('HH:mm').format(DateTime.now()).obs;
  var endTime = "9:30".obs;

  getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: Get.context!,
      initialTime: TimeOfDay(
        hour: int.parse(startTime.value.split(":")[0]),
        minute: int.parse(startTime.value.split(":")[1].split(" ")[0]),
      ),
    );
    if (pickedTime != null) {
      String formattedTime = pickedTime.format(Get.context!);
      if (isStartTime) {
        startTime.value = formattedTime;
      } else {
        endTime.value = formattedTime;
      }
    } else {
      print("Time canceled");
    }
  }


  var selectedRemind = 5.obs;

  updateRemind(int newValue) {
    selectedRemind.value = newValue;
  }

  var selectedRepeat = "None".obs;

  updateRepeat(String newValue) {
    selectedRepeat.value = newValue;
  }
  var selectedColor = 0.obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  void validateData() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      // add to database
      addTaskToDb();
      Get.back();
    } else {
      Get.snackbar(
        "Required",
        "All fields are required!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        backgroundColor: CColors.white,
        icon: Icon(Icons.warning_amber_rounded),
      );
    }
  }

  void addTaskToDb() async{
    int value = await addTask( task:PersonalTask(
    title: titleController.text,
    note: noteController.text,
    date: DateFormat("dd/MM/yyyy").format(selectedDate.value),
    startTime: startTime.value,
    endTime: endTime.value,
    color: selectedColor.value,
    remind: selectedRemind.value,
    repeat: selectedRepeat.value,
    isCompleted: 0,
    )
    );

    print("My id is "+"$value ");

    // Assuming you have a method in your database helper class to add a task
    // DatabaseHelper.instance.addTask(task);

    // For now, we will just print the task to console
  }

  var taskList = <PersonalTask>[].obs;

  Future<int> addTask({PersonalTask? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new PersonalTask.fromJson(data)).toList());
  }

  void delete(PersonalTask task) {
  DBHelper.delete(task);
  getTasks();
  }

  void markTaskCompleted(int? id) async {
    await DBHelper.update(id);
    getTasks();
  }

  // Sapxep theo thoi gian bat dau
  int _compareTime(String? time1, String? time2) {
    DateTime dateTime1 = DateFormat("HH:mm").parse(time1.toString());
    DateTime dateTime2 = DateFormat("HH:mm").parse(time2.toString());
    return dateTime1.compareTo(dateTime2);
  }
  void sortTime() {
    taskList.sort((a, b) => _compareTime(a.startTime, b.startTime));
  }
}


