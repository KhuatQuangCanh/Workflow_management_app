

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/models/comment_model.dart';

import '../../../utils/Exceptions/firebase_exceptions.dart';
class CommentRepository extends GetxController {
  static CommentRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveComment(CommentModel comment) async {
    try {
      await _db.collection("Comments").doc(comment.id).set(comment.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error saving comment: $e');
    }
  }

  Future<CommentModel> fetchCommentDetail(String commentId) async {
    try {
      final documentSnapshot = await _db.collection("Comments").doc(commentId).get();
      if (documentSnapshot.exists) {
        return CommentModel.fromSnapshot(documentSnapshot);
      } else {
        throw Exception('Comment not found');
      }
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching comment: $e');
    }
  }

  Future<void> updateComment(CommentModel comment) async {
    try {
      await _db.collection("Comments").doc(comment.id).update(comment.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error updating comment: $e');
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await _db.collection("Comments").doc(commentId).delete();
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting comment: $e');
    }
  }

  Future<List<CommentModel>> fetchCommentsByTaskId(String taskId) async {
    try {
      final querySnapshot = await _db.collection("Comments")
          .where('taskId', isEqualTo: taskId)
          .get();
      return querySnapshot.docs.map((doc) => CommentModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception('Error getting comments: ${e.message}');
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