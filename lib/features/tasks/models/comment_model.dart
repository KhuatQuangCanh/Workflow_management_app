import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String userId;
  final String taskId;
  final String content;
  final DateTime createdAt;
  final List<String> attachmentUrls;

  CommentModel({
    required this.id,
    required this.userId,
    required this.taskId,
    required this.content,
    required this.createdAt,
    required this.attachmentUrls,
  });

  CommentModel copyWith({
    String? id,
    String? userId,
    String? taskId,
    String? content,
    DateTime? createdAt,
    List<String>? attachmentUrls,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      taskId: taskId ?? this.taskId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
    );
  }

  static CommentModel empty() => CommentModel(
    id: '',
    taskId: '',
    userId: '',
    content: '',
    createdAt: DateTime.now(),
    attachmentUrls: [],
  );

  factory CommentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CommentModel(
      id: document.id,
      userId: data['userId'],
      taskId: data['taskId'],
      content: data['content'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      attachmentUrls:  List<String>.from(data['attachmentUrls']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'taskId': taskId,
      'content': content,
      'createdAt': createdAt,
      'attachmentUrls': attachmentUrls,
    };
  }

  @override
  String toString() {
    return 'CommentModel{id: $id, taskId: $taskId, userId: $userId, content: $content, createdAt: $createdAt, attachmentUrls: $attachmentUrls}';
  }

}
