
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/utils/Exceptions/firebase_exceptions.dart';
import 'package:workflow_management_app/utils/Exceptions/format_exceptions.dart';
import 'package:workflow_management_app/utils/Exceptions/platform_exceptions.dart';

import '../../../features/tasks/models/group_model.dart';



class GroupRepository extends GetxController {
  static GroupRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveGroup(GroupModel group) async {
    try {
      await _db.collection("Groups").doc(group.id).set(group.toJson());
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<GroupModel> fetchGroupDetail(String groupId) async {
    try {
      final documentSnapshot = await _db.collection("Groups").doc(groupId).get();
      if (documentSnapshot.exists) {
        return GroupModel.fromSnapshot(documentSnapshot);
      } else {
        return GroupModel.empty();
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateGroup(GroupModel updatedGroup) async {
    try {
      await _db.collection("Groups").doc(updatedGroup.id).update(updatedGroup.toJson());
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteGroup(String groupId) async {
    try {
      await _db.collection("Groups").doc(groupId).delete();
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<GroupModel>> fetchAllGroups() async {
    try {
      final querySnapshot = await _db.collection("Groups").get();
      return querySnapshot.docs.map((doc) => GroupModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
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
}

