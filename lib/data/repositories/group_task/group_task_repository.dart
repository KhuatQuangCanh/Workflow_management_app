import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/models/task_model.dart';
import '../../../utils/Exceptions/firebase_exceptions.dart';

class TaskRepository extends GetxController {
  static TaskRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lưu task
  Future<void> saveTask(TaskModel task) async {
    await _handleFirestoreOperation(() async {
      await _db.collection("Tasks").doc(task.id).set(task.toJson());
    });
  }

  // Lấy thông tin task
  Future<TaskModel> fetchTaskDetail(String taskId) async {
    return await _handleFirestoreOperation(() async {
      final documentSnapshot = await _db.collection("Tasks").doc(taskId).get();
      if (documentSnapshot.exists) {
        return TaskModel.fromSnapshot(documentSnapshot);
      } else {
        return TaskModel.empty();
      }
    });
  }

  // Cập nhật thông tin task
  Future<void> updateTask(TaskModel updatedTask) async {
    await _handleFirestoreOperation(() async {
      await _db.collection("Tasks").doc(updatedTask.id).update(updatedTask.toJson());
    });
  }

  // Xóa task
  Future<void> removeTask(String taskId) async {
    await _handleFirestoreOperation(() async {
      await _db.collection("Tasks").doc(taskId).delete();
    });
  }

  Future<T> _handleFirestoreOperation<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
