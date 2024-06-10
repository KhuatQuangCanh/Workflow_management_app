import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/data/repositories/group_task/task_repository.dart';
import 'package:workflow_management_app/data/repositories/user_group/userGroup_repository.dart';
import 'package:workflow_management_app/data/repositories/user_task/userTask_repository.dart';
import 'package:workflow_management_app/features/tasks/models/group_model.dart';
import 'package:workflow_management_app/data/repositories/group/group_repository.dart';
import 'package:workflow_management_app/data/repositories/user/user_repository.dart';
import 'package:workflow_management_app/features/personalization/models/user_model.dart';
import 'package:workflow_management_app/features/tasks/models/user_group_model.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/edit_member.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/group_detail.dart';
import 'package:workflow_management_app/navigation_menu.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';

import '../../../personalization/controllers/user_controller.dart';
import '../../models/task_model.dart';

class GroupController extends GetxController {
  static GroupController get instance => Get.find();

  final GroupRepository _groupRepo = Get.put(GroupRepository());
  final UserRepository _userRepo = Get.put(UserRepository());
  final TaskRepository _taskRepo = Get.put(TaskRepository());
  final UserTaskRepository _userTaskRepository = Get.put(UserTaskRepository());


  final GroupUserRepository _groupUserRepo = Get.put(GroupUserRepository());
  final RxList<GroupUserModel> groupUsers = <GroupUserModel>[].obs;
  // Danh sách các nhóm mà người dùng hiện tại thuộc vào
  final RxList<GroupModel> userGroups = <GroupModel>[].obs;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  final startTime = Rx<DateTime?>(null);
  final endTime = Rx<DateTime?>(null);
  var formattedStartTime = ''.obs;
  var formattedEndTime = ''.obs;
  final attachments = <File>[].obs;
  final RxList<PlatformFile> documents = <PlatformFile>[].obs;
  final participants = <UserModel>[].obs;
  RxInt participantsCount = 0.obs;
  final RxList<String> attachmentUrls = <String>[].obs;

  final RxList<UserModel> getparticipants = <UserModel>[].obs;
  final RxBool isCreator = false.obs;

  String UserId = AuthenticationRepository.instance.authUser!.uid;
  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    fetchUserGroups();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.onClose();
  }



  Future<void> pickStartTime(BuildContext context) async {
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
        final dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        startTime.value = dateTime;
        formattedStartTime.value = formatDateTime(dateTime);
      }
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
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
        final dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        endTime.value = dateTime;
        formattedEndTime.value = formatDateTime(dateTime);
      }
    }
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dateTime);
  }

  Future<UserModel?> searchUserByPhoneNumber(String phoneNumber) async {
    final users = await _userRepo.fetchAllUsers();
    try {
      final user = users.firstWhere((user) => user.phoneNumber == phoneNumber);
      return user;
    } catch (e) {
      return null;
    }
  }

  void addParticipant(UserModel participant) {
    participants.add(participant);
  }

  // Xóa người tham gia
  void removeParticipant(UserModel participant) {
    participants.remove(participant);
  }

  void addMember(UserModel participant) {
    getparticipants.add(participant);
  }

  // Xóa người tham gia
  void removeMember(UserModel participant) {
    getparticipants.remove(participant);
  }

  Future<void> addDocument(PlatformFile platformFile) async {
    documents.add(platformFile);
  }

  void removeDocument(PlatformFile platformFile) {
    documents.remove(platformFile);
  }
  void removeAttachmentUrl(String url) {
    attachmentUrls.remove(url);
  }

  Future<void> createGroup() async {
    try {
      if (titleController.text.isEmpty ||
          startTime.value == null ||
          endTime.value == null) {
        throw 'Please fill in all required fields';
      }

      // Tải lên các tệp được chọn và nhận danh sách các URL
      final List<String> attachmentUrls =
          await _groupRepo.uploadFiles(documents);

      final newGroup = GroupModel(
        id: FirebaseFirestore.instance.collection('Groups').doc().id,
        title: titleController.text,
        description: descriptionController.text,
        startTime: startTime.value!,
        endTime: endTime.value!,
        location: locationController.text,
        attachmentUrls: attachmentUrls,
        color: '',
      );

      // Lưu group vào Firestore
      await _groupRepo.saveGroup(newGroup);

      // Tạo danh sách người tham gia mặc định
      participants.add(UserController.instance.user
          .value); // Thêm người tạo group vào danh sách người tham gia

      // Lưu các người tham gia vào bảng phụ GroupUser
      for (final participant in participants) {
        final groupUser = GroupUserModel(
          id: FirebaseFirestore.instance.collection('GroupUsers').doc().id,
          userId: participant.id,
          groupId: newGroup.id,
          role: participant.id == UserController.instance.user.value.id
              ? 'creator'
              : 'member', // Gán vai trò creator cho người tạo group, member cho các thành viên khác
        );
        await _groupUserRepo.saveGroupUser(groupUser);
      }

      Get.snackbar("Success", "Group created successfully");
      await fetchUserGroups();
      clearFields();
      // Chuyển đến màn hình chi tiết group
      Get.off(() => GroupDetailScreen(group: newGroup));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    startTime.value = null;
    endTime.value = null;
    // attachments.clear();
    documents.clear();
    participants.clear();
  }

  Future<void> fetchUserGroups() async {
    try {
      final List<GroupUserModel> userGroupModels = await _groupUserRepo
          .fetchGroupUsersByUserId(AuthenticationRepository.instance.authUser!.uid);
      final List<String> groupIds =
          userGroupModels.map((groupUser) => groupUser.groupId).toList();
      // Lấy thông tin của các nhóm từ danh sách các ID nhóm
      final List<GroupModel> groups =
          await _groupRepo.fetchGroupsByIds(groupIds);
      userGroups.assignAll(groups);
    } catch (e) {
      print("Error fetching user groups: $e");
    }
  }

  Future<void> fetchGroupParticipantsCount(String groupId) async {
    try {
      final List<GroupUserModel> groupUsers = await _groupUserRepo.fetchGroupUsersByGroupId(groupId);
      participantsCount.value = groupUsers.length;
    } catch (e) {
      print("Error fetching group participants count: $e");
      participantsCount.value = 0;
    }
  }

  Future<void> updateGroup(String groupId) async {
    try {
      if (titleController.text.isEmpty ||
          startTime.value == null ||
          endTime.value == null) {
        throw 'Please fill in all required fields';
      }

      final List<String> newAttachmentUrls = await _groupRepo.uploadFiles(documents);

      final updatedGroup = GroupModel(
        id: groupId,
        title: titleController.text,
        description: descriptionController.text,
        startTime: startTime.value!,
        endTime: endTime.value!,
        location: locationController.text,
        attachmentUrls: [...attachmentUrls, ...newAttachmentUrls],
        color: '',
      );

      await _groupRepo.updateGroup(updatedGroup);

      Get.snackbar("Success", "Group updated successfully");
      await fetchUserGroups();
      // Chuyển đến màn hình chi tiết group
      Get.off(() => GroupDetailScreen(group: updatedGroup));
      clearFields();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchGroupParticipants(String groupId) async {
    try {
      final List<GroupUserModel> groupUsers = await _groupUserRepo.fetchGroupUsersByGroupId(groupId);
      final List<UserModel> users = [];

      for (final groupUser in groupUsers) {
        final user = await _userRepo.fetchUserById(groupUser.userId);
        if (user != null) {
          users.add(user);
        }
      }
      getparticipants.assignAll(users);

      // Kiểm tra nếu người dùng hiện tại là người tạo nhóm
      isCreator.value = groupUsers.any((groupUser) =>
      groupUser.userId == UserId &&
          groupUser.role == 'creator');
    } catch (e) {
      Get.snackbar("Error", "Error fetching participants: $e");
    }
  }
  Future<void> updateMember(String groupId) async {
    try {
      final groupUsers = await _groupUserRepo.fetchGroupUsersByGroupId(groupId);

      // Xóa các thành viên hiện tại
      for (final groupUser in groupUsers) {
        await _groupUserRepo.deleteGroupUser(groupUser.id);
      }

      // Thêm các thành viên mới
      for (final participant in getparticipants) {
        final groupUser = GroupUserModel(
          id: FirebaseFirestore.instance.collection('GroupUsers').doc().id,
          userId: participant.id,
          groupId: groupId,
          role: participant.id == UserId ? 'creator' : 'member',
        );
        await _groupUserRepo.saveGroupUser(groupUser);
      }

      Get.snackbar("Success", "Members updated successfully");
      fetchGroupParticipants(groupId);
    } catch (e) {
      Get.snackbar("Error", "Error updating members: $e");
    }
  }
  Future<void> deleteGroup(String groupId) async {
    try {
      // Lấy danh sách task của group
      final groupTasks = await _taskRepo.getTasksByGroupId(groupId);

      // Xóa các task của group
      for (final task in groupTasks) {
        // Xóa các comment của task
        await _taskRepo.deleteTaskComments(task.id);

        // Xóa các user task của task
        await _userTaskRepository.deleteUserTasksByTaskId(task.id);

        // Xóa task
        await _taskRepo.deleteTask(task.id);
      }

      // Xóa các người tham gia group
      await _groupUserRepo.deleteGroupUsersByGroupId(groupId);

      // Xóa group
      await _groupRepo.deleteGroup(groupId);
      await fetchUserGroups();
      Get.back();
      Get.snackbar("Success", "Group deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Error deleting group: $e");
    }
  }
}
