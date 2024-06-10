import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/features/tasks/models/task_model.dart';

class TaskRepository extends GetxController {
  static TaskRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveTask(TaskModel task) async {
    try {
      await _db.collection("Tasks").doc(task.id).set(task.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error saving task: $e');
    }
  }

  Future<TaskModel> fetchTaskDetail(String taskId) async {
    try {
      final documentSnapshot = await _db.collection("Tasks").doc(taskId).get();
      if (documentSnapshot.exists) {
        return TaskModel.fromSnapshot(documentSnapshot);
      } else {
        throw Exception('Task not found');
      }
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _db.collection("Tasks").doc(task.id).update(task.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _db.collection("Tasks").doc(taskId).delete();
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }

  Future<List<TaskModel>> getTasksByGroupId(String groupId) async {
    try {
      final querySnapshot = await _db.collection("Tasks")
          .where('groupId', isEqualTo: groupId)
          .get();
      return querySnapshot.docs.map((doc) => TaskModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception('Error getting tasks: ${e.message}');
    }
  }

}