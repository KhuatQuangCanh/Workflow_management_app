

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/models/comment_model.dart';

import '../../../utils/Exceptions/firebase_exceptions.dart';

class CommentRepository extends GetxController {
  static CommentRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lưu comment
  Future<void> saveComment(CommentModel comment) async {
    try {
      await _db.collection("Comments").doc(comment.id).set(comment.toJson());
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Lấy thông tin comment
  Future<CommentModel> fetchCommentDetail(String commentId) async {
    try {
      final documentSnapshot = await _db.collection("Comments").doc(commentId).get();
      if (documentSnapshot.exists) {
        return CommentModel.fromSnapshot(documentSnapshot);
      } else {
        return CommentModel.empty();
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Cập nhật thông tin comment
  Future<void> updateComment(CommentModel updatedComment) async {
    try {
      await _db.collection("Comments").doc(updatedComment.id).update(updatedComment.toJson());
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Xóa comment
  Future<void> removeComment(String commentId) async {
    try {
      await _db.collection("Comments").doc(commentId).delete();
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
