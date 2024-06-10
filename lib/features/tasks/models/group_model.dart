import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workflow_management_app/features/tasks/models/task_model.dart';

class GroupModel {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final List<String> attachmentUrls;
  final String color;

  GroupModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.attachmentUrls,
    required this.color,
  });
  static GroupModel empty() => GroupModel(
    id: '',
    title: '',
    description: '',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    location: '',
    attachmentUrls: [],
    color: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
      'attachmentUrls': attachmentUrls,
      'color': color,
    };
  }

  factory GroupModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return GroupModel(
      id: document.id,
      title: data['title'],
      description: data['description'],
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      location: data['location'],
      attachmentUrls: List<String>.from(data['attachmentUrls']),
      color: data['color'],
    );
  }

  @override
  String toString() {
    return 'GroupModel{id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, attachmentUrls: $attachmentUrls, color: $color}';
  }



}
