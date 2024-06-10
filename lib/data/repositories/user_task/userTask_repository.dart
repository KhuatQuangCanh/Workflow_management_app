
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/models/user_task_model.dart';

class UserTaskRepository extends GetxController {
  static UserTaskRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserTask(UserTaskModel userTask) async {
    try {
      await _db.collection("UserTasks").doc(userTask.id).set(userTask.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error saving user task: $e');
    }
  }

  Future<UserTaskModel> fetchUserTaskDetail(String userTaskId) async {
    try {
      final documentSnapshot = await _db.collection("UserTasks").doc(userTaskId).get();
      if (documentSnapshot.exists) {
        return UserTaskModel.fromSnapshot(documentSnapshot);
      } else {
        throw Exception('User task not found');
      }
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching user task: $e');
    }
  }

  Future<void> updateUserTask(UserTaskModel userTask) async {
    try {
      await _db.collection("UserTasks").doc(userTask.id).update(userTask.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error updating user task: $e');
    }
  }

  Future<void> deleteUserTask(String userTaskId) async {
    try {
      await _db.collection("UserTasks").doc(userTaskId).delete();
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting user task: $e');
    }
  }

  Future<List<UserTaskModel>> fetchUserTasksByUserId(String userId) async {
    try {
      final querySnapshot = await _db.collection("UserTasks")
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => UserTaskModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception('Error getting user tasks: ${e.message}');
    }
  }
  Future<List<UserTaskModel>> fetchUserTasksByTaskId(String taskId) async {
    try {
      final querySnapshot = await _db.collection("UserTasks")
          .where('taskId', isEqualTo: taskId)
          .get();
      return querySnapshot.docs.map((doc) => UserTaskModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception('Error getting user tasks: ${e.message}');
    }
  }
  Future<void> deleteUserTasksByTaskId(String taskId) async {
    try {
      final querySnapshot = await _db.collection("UserTasks")
          .where('taskId', isEqualTo: taskId)
          .get();
      final List<String> userTaskIds = querySnapshot.docs.map((doc) => doc.id).toList();
      for (String userTaskId in userTaskIds) {
        await _db.collection("UserTasks").doc(userTaskId).delete();
      }
    } on FirebaseException catch (e) {
      throw Exception('Error deleting user tasks: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting user tasks: $e');
    }
  }
}