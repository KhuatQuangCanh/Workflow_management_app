import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/data/repositories/group_task/group_task_repository.dart';
import 'package:workflow_management_app/features/tasks/models/task_model.dart';
import '../../../personalization/models/user_model.dart';
import '../group/group_controller.dart';
enum UserType { participant, manager }
class TaskController extends GetxController {
  static TaskController get instance => Get.find<TaskController>();

  final TaskRepository _taskRepo = TaskRepository();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startTime = Rx<DateTime?>(null);
  final endTime = Rx<DateTime?>(null);
  final notificationMinutesBefore = 5.obs;
  var selectedParticipantsIds = <String>[].obs;
  var formattedStartTime = ''.obs;
  var formattedEndTime = ''.obs;
  var participants = <UserModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }




  Future<void> pickStartTime(BuildContext context) async {
    final dateTime = await _pickDateTime(context);
    if (dateTime != null) {
      startTime.value = dateTime;
      formattedStartTime.value = formatDateTime(dateTime);
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final dateTime = await _pickDateTime(context);
    if (dateTime != null) {
      endTime.value = dateTime;
      formattedEndTime.value = formatDateTime(dateTime);
    }
  }

  Future<DateTime?> _pickDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return null;
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dateTime);
  }

  // List<UserModel> get groupParticipants {
  //   if (GroupController.instance != null &&
  //       GroupController.instance.participants.isNotEmpty) {
  //     return GroupController.instance.participants;
  //   } else {
  //     return [];
  //   }
  // }

  Future<void> addParticipant(UserModel user) async {
    if (!participants.contains(user)) {
      participants.add(user);
    }
  }

  Future<void> removeParticipant(UserModel user) async {
    participants.remove(user);
    selectedParticipantsIds.remove(user.id);
  }

  Future<void> createAndSaveTask(String groupId) async {
    try {
      if (titleController.text.isEmpty ||
          startTime.value == null ||
          endTime.value == null) {
        throw 'Please fill in all required fields';
      }

      final newTask = TaskModel(
        id: FirebaseFirestore.instance.collection('Tasks').doc().id,
        title: titleController.text,
        description: descriptionController.text,
        groupId: groupId,
        assigneeIds:participants.map((user) => user.id).toList(),
        startTime: startTime.value!,
        endTime: endTime.value!,
        isCompleted: false,
        notificationMinutesBefore: notificationMinutesBefore.value,
      );

      await _taskRepo.saveTask(newTask);
      Get.back(closeOverlays: true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    try {
      await _taskRepo.updateTask(updatedTask);
      Get.back(closeOverlays: true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}

