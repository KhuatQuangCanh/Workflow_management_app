import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/data/repositories/group_task/task_repository.dart';
import 'package:workflow_management_app/data/repositories/user_group/userGroup_repository.dart';
import 'package:workflow_management_app/data/repositories/user_task/userTask_repository.dart';
import 'package:workflow_management_app/features/tasks/models/task_model.dart';
import 'package:workflow_management_app/features/tasks/models/user_group_model.dart';
import 'package:workflow_management_app/features/tasks/models/user_task_model.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/group_model.dart';

enum UserType { participant, manager }

class TaskController extends GetxController {
  static TaskController get instance => Get.find<TaskController>();

  final TaskRepository _taskRepo = Get.put(TaskRepository());
  final UserRepository _userRepo = Get.put(UserRepository());
  final GroupUserRepository _groupUserRepo = Get.put(GroupUserRepository());
  final UserTaskRepository _userTaskRepository = Get.put(UserTaskRepository());
  RxList<TaskModel> groupTasks = <TaskModel>[].obs;
  RxList<TaskModel> userTasks = <TaskModel>[].obs;
  var groupModel = <GroupModel>[].obs;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startTime = Rx<DateTime?>(null);
  final endTime = Rx<DateTime?>(null);
  var selectedParticipantsIds = <String>[].obs;
  var formattedStartTime = ''.obs;
  var formattedEndTime = ''.obs;
  var participants = <UserModel>[].obs;
  RxBool isCompleted = false.obs;
  RxList<UserModel> assignedUsers = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ever(groupTasks, (_) {
      // Gọi update() để cập nhật giao diện khi groupTasks thay đổi
      update();
    });
    ever(userTasks, (_) {
      // Gọi update() để cập nhật giao diện khi groupTasks thay đổi
      update();
    });
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

      final userTasksInGroup =
          await _userTaskRepository.fetchUserTasksByUserId(currentUser);
      final taskIds =
          userTasksInGroup.map((userTask) => userTask.taskId).toList();
      final userTasksFiltered =
          groupTasks.where((task) => taskIds.contains(task.id)).toList();

      userTasks.assignAll(userTasksFiltered);
    } catch (e) {
      print("Error fetching user tasks in group: $e");
    }
  }

  Future<void> showParticipantsDialog(
      BuildContext context, String groupId) async {
    try {
      // Lấy danh sách người tham gia nhóm
      final List<GroupUserModel> groupUsers =
          await _groupUserRepo.fetchGroupUsersByGroupId(groupId);
      final List<UserModel> participantsList = [];

      for (final groupUser in groupUsers) {
        final user = await _userRepo.fetchUserById(groupUser.userId);
        if (user != null) {
          participantsList.add(user);
        }
      }

      // Hiển thị dialog với danh sách người tham gia
      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Text('Members :'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ...participantsList
                      .map((user) => CheckboxListTile(
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
                          ))
                      .toList(),
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

  Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await _taskRepo.updateTaskCompletion(taskId, isCompleted);
      final taskIndex = groupTasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        final updatedTask =
            groupTasks[taskIndex].copyWith(isCompleted: isCompleted);
        groupTasks[taskIndex] = updatedTask;
        userTasks[taskIndex] = updatedTask;
      }
      Get.snackbar("Success", "Task marked as done");
    } catch (e) {
      Get.snackbar("Error", "Error updating task completion: $e");
    }
  }

  Future<void> fetchAssignedUsers(String taskId) async {
    try {
      final userTasks =
          await _userTaskRepository.fetchUserTasksByTaskId(taskId);
      final userIds = userTasks.map((userTask) => userTask.userId).toList();
      final users = await _userRepo.getUsersByIds(userIds);
      assignedUsers.assignAll(users);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> editTask(String taskId, String newTitle, String newDescription,
      DateTime newStartTime, DateTime newEndTime, String groupId) async {
    try {
      // Tạo một đối tượng task mới với thông tin đã cập nhật
      final updatedTask = TaskModel(
        id: taskId,
        title: newTitle,
        description: newDescription,
        startTime: newStartTime,
        endTime: newEndTime,
        isCompleted: false,
        groupId: groupId,
      );

      // Cập nhật task trong Firestore
      await _taskRepo.updateTask(updatedTask);

      // Cập nhật danh sách task trong ứng dụng
      final taskIndex = groupTasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        groupTasks[taskIndex] = updatedTask;
        userTasks[taskIndex] = updatedTask;
      }

      Get.snackbar("Success", "Task updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Error updating task: $e");
    }
  }

  Future<void> showEditTaskDialog(BuildContext context, TaskModel task) async {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    DateTime startTime = task.startTime;
    DateTime endTime = task.endTime;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Start Time'),
                  readOnly: true,
                  onTap: () async {
                    final dateTime = await _pickDateTime(context);
                    if (dateTime != null) {
                      startTime = dateTime;
                    }
                  },
                  controller: TextEditingController(
                      text: DateFormat("dd/MM/yyyy HH:mm").format(startTime)),
                ),
                SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'End Time'),
                  readOnly: true,
                  onTap: () async {
                    final dateTime = await _pickDateTime(context);
                    if (dateTime != null) {
                      endTime = dateTime;
                    }
                  },
                  controller: TextEditingController(
                      text: DateFormat("dd/MM/yyyy HH:mm").format(endTime)),
                ),
                SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await TaskController.instance.editTask(
                  task.id,
                  titleController.text,
                  descriptionController.text,
                  startTime,
                  endTime,
                  task.groupId,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<DateTime?> _DateTime(BuildContext context) async {
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

  Future<void> deleteTask(String taskId) async {
    try {
      // Xóa các comment liên quan đến task trước
      await _taskRepo.deleteTaskComments(taskId);

      // Xóa các người tham gia task
      await _userTaskRepository.deleteUserTasksByTaskId(taskId);

      // Xóa task
      await _taskRepo.deleteTask(taskId);

      // Cập nhật danh sách task trong ứng dụng
      groupTasks.removeWhere((task) => task.id == taskId);
      userTasks.removeWhere((task) => task.id == taskId);

      Get.snackbar("Success", "Task deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Error deleting task: $e");
    }
  }
}
