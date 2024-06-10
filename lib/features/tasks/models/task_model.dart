import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;
  final String groupId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
    required this.groupId,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? groupId,
    DateTime? startTime,
    DateTime? endTime,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      groupId: groupId ?? this.groupId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }


  static TaskModel empty() => TaskModel(
    id: '',
    title: '',
    description: '',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    isCompleted: false,
    groupId: '',
  );

  factory TaskModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TaskModel(
      id: document.id,
      title: data['title'],
      description: data['description'],
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      isCompleted: data['isCompleted'],
      groupId: data['groupId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'isCompleted': isCompleted,
      'groupId': groupId,
    };
  }
  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted, groupId: $groupId}';
  }
}
