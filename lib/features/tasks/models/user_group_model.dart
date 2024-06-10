
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupUserModel {
  final String id;
  final String userId;
  final String groupId;
  final String role;

  GroupUserModel({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.role,
  });

  factory GroupUserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return GroupUserModel(
      id: document.id,
      userId: data['userId'],
      groupId: data['groupId'],
      role: data['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'groupId': groupId,
      'role': role,
    };
  }
}