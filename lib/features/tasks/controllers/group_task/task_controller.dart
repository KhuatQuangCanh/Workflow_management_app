import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/data/repositories/group_task/task_repository.dart';
import 'package:workflow_management_app/data/repositories/user_group/userGroup_repository.dart';
import 'package:workflow_management_app/data/repositories/user_task/userTask_repository.dart';
import 'package:workflow_management_app/features/tasks/models/task_model.dart';
import 'package:workflow_management_app/features/tasks/models/user_group_model.dart';
import 'package:workflow_management_app/features/tasks/models/user_task_model.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/group_detail.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import '../../../../data/repositories/group/group_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/group_model.dart';
import '../group/group_controller.dart';

enum UserType { participant, manager }

class TaskController extends GetxController {
  static TaskController get instance => Get.find<TaskController>();

  final TaskRepository _taskRepo = Get.put(TaskRepository());
  final UserRepository _userRepo = Get.put(UserRepository());
  final GroupUserRepository _groupUserRepo = Get.put(GroupUserRepository());
  final UserTaskRepository _userTaskRepository = Get.put(UserTaskRepository());
  RxList<TaskModel> groupTasks = <TaskModel>[].obs;
  RxList<TaskModel> userTasks = <TaskModel>[].obs;
  var groupModel =  <GroupModel>[].obs;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startTime = Rx<DateTime?>(null);
  final endTime = Rx<DateTime?>(null);
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
        startTime: startTime.value!,
        endTime: endTime.value!,
        isCompleted: false,
        groupId: groupId,
      );
      for (final participant in participants) {
        final taskUser = UserTaskModel(
          id: FirebaseFirestore.instance.collection('UserTasks').doc().id,
          userId: participant.id,
          taskId: newTask.id,

        );
        await _userTaskRepository.saveUserTask(taskUser);
      }

      await _taskRepo.saveTask(newTask);

      titleController.clear();
      descriptionController.clear();
      startTime.value = null;
      endTime.value = null;
      formattedStartTime.value = '';
      formattedEndTime.value = '';
      participants.clear();
      Get.back();
      fetchTasksByGroupId(groupId);
      fetchUserTasksInGroup(groupId);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchTasksByGroupId(String groupId) async {
    try {
      final tasks = await _taskRepo.getTasksByGroupId(groupId);
      groupTasks.assignAll(tasks);
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Error fetching tasks by groupId: $e");
    }
  }
  Future<void> fetchUserTasksInGroup(String groupId) async {
    try {
      await fetchTasksByGroupId(groupId);
      final currentUser = AuthenticationRepository.instance.authUser?.uid;
      if (currentUser == null) throw Exception("User not authenticated");

      final userTasksInGroup = await _userTaskRepository.fetchUserTasksByUserId(currentUser);
      final taskIds = userTasksInGroup.map((userTask) => userTask.taskId).toList();
      final userTasksFiltered = groupTasks.where((task) => taskIds.contains(task.id)).toList();

      userTasks.assignAll(userTasksFiltered);
    } catch (e) {
      print("Error fetching user tasks in group: $e");
    }
  }

  // Future<void> fetchUserTasks(String userId) async {
  //   final userTasksList = await _userTaskRepository.getUserTasks(userId);
  //   userTasks.assignAll(userTasksList);
  // }

  Future<void> showParticipantsDialog(BuildContext context, String groupId) async {
    try {
      // Lấy danh sách người tham gia nhóm
      final List<GroupUserModel> groupUsers = await _groupUserRepo.fetchGroupUsersByGroupId(groupId);
      final List<UserModel> participantsList = [];

      for (final groupUser in groupUsers) {
        final user = await _userRepo.fetchUserById(groupUser.userId);
        if (user != null) {
          participantsList.add(user);
        }
      }

      // Hiển thị dialog với danh sách người tham gia
      showDialog(
        context:Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Text('Members :'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ...participantsList.map((user) => CheckboxListTile(
                    value: participants.contains(user),
                    title: Text(user.fullName),
                    onChanged: (isSelected) {
                      if (isSelected == true) {
                        if (!participants.contains(user)) {
                          participants.add(user);
                        }
                      } else {
                        if (participants.contains(user)) {
                          participants.remove(user);
                        }
                      }
                      Navigator.of(context).pop();
                      showParticipantsDialog(Get.context!, groupId);
                    },
                  )).toList(),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      Get.snackbar("Error", "Error fetching participants: $e");
    }
  }

  void removeParticipant(UserModel participant) {
    participants.remove(participant);
  }
}
