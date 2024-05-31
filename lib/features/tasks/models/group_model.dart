import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workflow_management_app/features/tasks/models/task_model.dart';

class GroupModel {
  final String id;
  final String title;
  final String description;
  final String ownerId;
  final DateTime startTime; // Thời gian bắt đầu của nhóm
  final DateTime endTime; // Thời gian kết thúc của nhóm
  final String location;
  List<String> managerIds; // Danh sách ID của các quản lý
  List<String> memberIds; // Danh sách ID của các thành viên
  List<String> taskIds; // Danh sách ID của các task trong nhóm
  List<String> attachmentUrls; // Các tệp đính kèm

  GroupModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ownerId,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.managerIds,
    required this.memberIds,
    required this.taskIds,
    required this.attachmentUrls,
  });

  static GroupModel empty() => GroupModel(
    id: '',
    title: '',
    description: '',
    ownerId: '',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    location: '',
    managerIds: [],
    memberIds: [],
    taskIds: [],
    attachmentUrls: [],
  );

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Description': description,
      'OwnerId': ownerId,
      'StartTime': startTime.toIso8601String(),
      'EndTime': endTime.toIso8601String(),
      'Location': location,
      'ManagerIds': managerIds,
      'MemberIds': memberIds,
      'TaskIds': taskIds,
      'AttachmentUrls': attachmentUrls,
    };
  }

  factory GroupModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? {};
    return GroupModel(
      id: document.id,
      title: data["Title"] ?? '',
      description: data["Description"] ?? '',
      ownerId: data["OwnerId"] ?? '',
      startTime: DateTime.parse(data["StartTime"] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(data["EndTime"] ?? DateTime.now().toIso8601String()),
      location: data["Location"] ?? '',
      managerIds: List<String>.from(data["ManagerIds"] ?? []),
      memberIds: List<String>.from(data["MemberIds"] ?? []),
      taskIds: List<String>.from(data["TaskIds"] ?? []),
      attachmentUrls: List<String>.from(data["AttachmentUrls"] ?? []),
    );
  }

  @override
  String toString() {
    return 'GroupModel{id: $id, title: $title, description: $description, ownerId: $ownerId, startTime: $startTime, endTime: $endTime, location: $location, managerIds: $managerIds, memberIds: $memberIds, taskIds: $taskIds, attachmentUrls: $attachmentUrls}';
  }


  void addTask(TaskModel task) {
    taskIds.add(task.id);
  }

  void removeTask(TaskModel task) {
    taskIds.remove(task.id);
  }

  List<TaskModel> getTasks(List<TaskModel> allTasks) {
    return allTasks.where((task) => taskIds.contains(task.id)).toList();
  }
}
