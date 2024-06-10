
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/features/personalization/models/user_model.dart';

import '../../../../data/repositories/comment/comment_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../models/comment_model.dart';

class CommentController extends GetxController {
  static CommentController get instance => Get.find<CommentController>();

  final CommentRepository _commentRepo = CommentRepository();
  final UserRepository _userRepo = Get.put(UserRepository());

  final UserController userController = Get.put(UserController());
  var comments = <CommentModel>[].obs;
  final contentController = TextEditingController();
  final attachmentUrls = <File>[].obs;
  final selectedComment = Rx<CommentModel?>(null);
  var commentUser = Rx<UserModel?>(null);
  final RxList<PlatformFile> documents = <PlatformFile>[].obs;
  // late String UserId;
  String UserId = AuthenticationRepository.instance.authUser!.uid;
  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    super.onInit();
    comments.refresh();
  }

  Future<void> fetchCommentsByTaskId(String taskId) async {
    final fetchedComments = await _commentRepo.fetchCommentsByTaskId(taskId);
    comments.assignAll(fetchedComments);
    update();
  }

  Future<void> addComment(String taskId) async {
    try {
      if (contentController.text.isEmpty) {
        throw 'Please enter some content';
      }
      final List<String> attachmentUrls = await _commentRepo.uploadFiles(documents);

      final newComment = CommentModel(
        id: FirebaseFirestore.instance.collection('Comments').doc().id,
        taskId: taskId,
        userId: UserId,
        content: contentController.text,
        createdAt: DateTime.now(),
        attachmentUrls: attachmentUrls,
      );

      await _commentRepo.saveComment(newComment);
      comments.add(newComment);
      fetchCommentsByTaskId(taskId);
      clearFields();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateComment(CommentModel comment) async {
    try {
      if (contentController.text.isEmpty) {
        throw 'Please enter some content';
      }
      final List<String> attachmentUrls = await _commentRepo.uploadFiles(documents);

      final updatedComment = comment.copyWith(
        content: contentController.text,
        attachmentUrls: attachmentUrls.isNotEmpty ? attachmentUrls : comment.attachmentUrls,
      );

      await _commentRepo.updateComment(updatedComment);
      final commentIndex = comments.indexWhere((c) => c.id == comment.id);
      if (commentIndex != -1) {
        comments[commentIndex] = updatedComment;
      }
      clearFields();
      selectedComment.value = null;
      fetchCommentsByTaskId(comment.taskId);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }


  Future<void> deleteComment(String commentId) async {
    try {
      await _commentRepo.deleteComment(commentId);
      comments.removeWhere((comment) => comment.id == commentId);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void clearFields() {
    contentController.clear();
    documents.clear();
  }

  void selectComment(CommentModel? comment) {
    if (comment != null) {
      selectedComment.value = comment;
      contentController.text = comment.content;
    } else {
      clearFields();
    }
  }

  Future<void> addDocument(PlatformFile platformFile) async {
    documents.add(platformFile);
  }

  void removeDocument(PlatformFile platformFile) {
    documents.remove(platformFile);
  }

  Future<UserModel?> fetchUserById(String userId) async {
    try {
      return await _userRepo.fetchUserById(userId);
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }
  Future<void> fetchCommentUser(String userId) async {
    final user = await _userRepo.fetchUserById(userId);
    commentUser.value = user;
  }

}