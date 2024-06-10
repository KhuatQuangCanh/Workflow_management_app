import 'package:cloud_firestore/cloud_firestore.dart';

class UserTaskModel {
  final String id;
  final String userId;
  final String taskId;

  UserTaskModel({
    required this.id,
    required this.userId,
    required this.taskId,
  });

  factory UserTaskModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserTaskModel(
      id: document.id,
      userId: data['userId'],
      taskId: data['taskId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'taskId': taskId,
    };
  }
}