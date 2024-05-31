import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/features/tasks/models/group_model.dart';
import 'package:workflow_management_app/data/repositories/group/group_repository.dart';
import 'package:workflow_management_app/data/repositories/user/user_repository.dart';
import 'package:workflow_management_app/features/personalization/models/user_model.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/group_tasks.dart';

import '../../models/task_model.dart';
enum UserType { participant, manager }
class GroupController extends GetxController {
  static GroupController get instance => Get.find();

  Rx<GroupModel> group = GroupModel.empty().obs;
  final Rx<List<GroupModel>> allGroups = Rx<List<GroupModel>>([]);

  final GroupRepository _groupRepo = GroupRepository();
  final UserRepository _userRepo = UserRepository();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  final startTime = Rx<DateTime?>(null);
  final endTime = Rx<DateTime?>(null);
  var formattedStartTime = ''.obs;
  var formattedEndTime = ''.obs;
  final attachments = <File>[].obs;
  var participantIds = <String>[].obs;
  var participants = <UserModel>[].obs;
  var managerIds = <String>[].obs;
  var managers = <UserModel>[].obs;

  late String ownerId;
  final RxList<PlatformFile> documents = <PlatformFile>[].obs;
  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    fetchUserId();
    fetchUserGroups();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.onClose();
  }

  Future<void> fetchUserId() async {
    final currentUser = await _userRepo.fetchUserDetail();
    if (currentUser != null) {
      ownerId = currentUser.id;
      fetchUserGroups();
    }
  }
  Future<void> fetchUserGroups() async {
    try {
      final List<GroupModel> groups = await _groupRepo.fetchAllGroups();
      final currentUserGroups = groups.where((group) =>
      group.ownerId == ownerId ||
          group.managerIds.contains(ownerId) ||
          group.memberIds.contains(ownerId)).toList();
      allGroups.value = currentUserGroups;
    } catch (e) {
      print("Error fetching user groups: $e");
    }
  }

  Future<void> pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        for (var platformFile in result.files) {
          final file = File(platformFile.path!);
          attachments.add(file);

        }
      }
    } catch (e) {
      Get.snackbar("Error", "Error picking files: $e");
    }
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

  Future<void> addParticipant(UserModel user) async {
    if (!participants.contains(user)) {
      participants.add(user);
    }
  }

  Future<void> addManager(UserModel user) async {
    if (!managers.contains(user)) {
      managers.add(user);
    }
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

  Future<void> fetchAllGroups() async {
    try {
      final List<GroupModel> groups = await _groupRepo.fetchAllGroups();
      allGroups.value = groups;
    } catch (e) {
      print("Error fetching all groups: $e");
    }
  }


  Future<void> addDocument(PlatformFile platformFile) async {
    documents.add(platformFile);
  }

  void removeDocument(PlatformFile platformFile) {
    documents.remove(platformFile);
  }

  Future<void> createGroup() async {
    try {
      if (titleController.text.isEmpty ||
          startTime.value == null ||
          endTime.value == null) {
        throw 'Please fill in all required fields';
      }

      // Kiểm tra xem có tệp nào được chọn không
      if (documents.isEmpty) {
        throw 'Please attach at least one document';
      }

      // Tải lên các tệp được chọn và nhận danh sách các URL
      final List<String> attachmentUrls = await _groupRepo.uploadFiles(documents);

      final newGroup = GroupModel(
        id: FirebaseFirestore.instance.collection('Groups').doc().id,
        title: titleController.text,
        description: descriptionController.text,
        ownerId: ownerId,
        startTime: startTime.value!,
        endTime: endTime.value!,
        location: locationController.text,
        managerIds: managers.map((user) => user.id).toList(),
        memberIds: participants.map((user) => user.id).toList(),
        taskIds: [],
        attachmentUrls: attachmentUrls,
      );

      await _groupRepo.saveGroup(newGroup);
      Get.snackbar("Success", "Group created successfully");
      await fetchUserGroups();
      Get.to(() => GroupTasksScreen(group: newGroup));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  Future<void> removeParticipant(UserModel user) async {
    participants.remove(user);
    participantIds.remove(user.id);
  }

  Future<void> removeManager(UserModel user) async {
    managers.remove(user);
    managerIds.remove(user.id);
  }
}
