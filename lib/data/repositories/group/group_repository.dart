
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/tasks/models/group_model.dart';



class GroupRepository extends GetxController {
  static GroupRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveGroup(GroupModel group) async {
    try {
      await _db.collection("Groups").doc(group.id).set(group.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error saving group: $e');
    }
  }

  Future<GroupModel> fetchGroupDetail(String groupId) async {
    try {
      final documentSnapshot = await _db.collection("Groups").doc(groupId).get();
      if (documentSnapshot.exists) {
        return GroupModel.fromSnapshot(documentSnapshot);
      } else {
        throw Exception('Group not found');
      }
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching group: $e');
    }
  }

  Future<void> updateGroup(GroupModel group) async {
    try {
      await _db.collection("Groups").doc(group.id).update(group.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error updating group: $e');
    }
  }

  Future<void> deleteGroup(String groupId) async {
    try {
      await _db.collection("Groups").doc(groupId).delete();
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting group: $e');
    }
  }

  Future<List<GroupModel>> fetchAllGroups() async {
    try {
      final querySnapshot = await _db.collection("Groups").get();
      return querySnapshot.docs.map((doc) => GroupModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching groups: $e');
    }
  }
  Future<List<String>> uploadFiles(List<PlatformFile> files) async {
    try {
      final List<String> urls = [];
      for (final file in files) {
        // Chuyển đổi PlatformFile thành File
        final File newFile = File(file.path!);
        // Tạo tham chiếu đến thư mục trên Firebase Storage
        final ref = FirebaseStorage.instance.ref().child('attachments/${file.name}');
        // Đặt tệp vào thư mục
        await ref.putFile(newFile);
        // Lấy URL của tệp đã tải lên
        final url = await ref.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } catch (e) {
      throw 'Error uploading files: $e';
    }
  }
  Future<List<GroupModel>> fetchGroupsByIds(List<String> groupIds) async {
    try {
      final List<GroupModel> groups = [];
      for (final groupId in groupIds) {
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _db.collection("Groups").doc(groupId).get();
        if (documentSnapshot.exists) {
          final group = GroupModel.fromSnapshot(documentSnapshot);
          groups.add(group);
        }
      }
      return groups;
    } catch (e) {
      print("Error fetching groups by ids: $e");
      throw e;
    }
  }
}

