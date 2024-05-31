import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String taskId;
  final String userId;
  final String content;
  final DateTime createdAt;
  List<String> attachmentUrls;

  CommentModel({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.attachmentUrls,
  });

  static CommentModel empty() => CommentModel(
    id: '',
    taskId: '',
    userId: '',
    content: '',
    createdAt: DateTime.now(),
    attachmentUrls: [],
  );

  Map<String, dynamic> toJson() {
    return {
      'TaskId': taskId,
      'UserId': userId,
      'Content': content,
      'CreatedAt': createdAt.toIso8601String(),
      'AttachmentUrls': attachmentUrls,
    };
  }

  factory CommentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? {};
    return CommentModel(
      id: document.id,
      taskId: data["TaskId"] ?? '',
      userId: data["UserId"] ?? '',
      content: data["Content"] ?? '',
      createdAt: DateTime.parse(data["CreatedAt"] ?? DateTime.now().toIso8601String()),
      attachmentUrls: List<String>.from(data["AttachmentUrls"] ?? []),
    );
  }
}
