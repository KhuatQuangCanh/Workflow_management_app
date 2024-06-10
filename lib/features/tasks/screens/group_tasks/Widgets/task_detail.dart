import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';
import 'package:workflow_management_app/features/tasks/models/task_model.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/comment_task.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/comment_title.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/button_add_task.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../../../personalization/controllers/user_controller.dart';
import '../../../../personalization/models/user_model.dart';
import '../../../controllers/comment/comment_controller.dart';
import '../../../controllers/group_task/task_controller.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    Get.put(CommentController());
    final taskController = TaskController.instance;
    final commentController = CommentController.instance;
    commentController.fetchCommentsByTaskId(task.id);
    // taskController.fetchParticipantsByGroupId(task.groupId);
    return Scaffold(
      appBar: CAppBar(
        title: Text("Task Detail"),
        showBackArrow: true,
        actions: [
          IconButton(
            onPressed: () async {
              await taskController.fetchAssignedUsers(task.id);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Assigned Users'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: taskController.assignedUsers.length,
                          itemBuilder: (context, index) {
                            final user = taskController.assignedUsers[index];
                            return ListTile(
                              title: Text(user.fullName), // Replace with the actual user property to display
                            );
                          },
                        );
                      }),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.groups),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              right: CSizes.defaultSpace,
              left: CSizes.defaultSpace,
              bottom: CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: dark ? CColors.darkGrey : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        color: dark ? Colors.white : CColors.dark,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: CSizes.spaceBtwItems),
                    Text(
                      'Description:',
                      style: TextStyle(
                          fontSize: 16,
                          color: dark ? CColors.darkerGrey : Colors.grey),
                    ),
                    Text(
                      task.description,
                      style: TextStyle(
                          fontSize: 16,
                          color: dark ? Colors.white : CColors.dark),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Start Time: ${DateFormat("HH:mm - dd/MM/yyyy").format(task.startTime)}',
                      style: TextStyle(
                          fontSize: 16,
                          color: dark ? Colors.white : CColors.dark),
                    ),
                    Text(
                      'End Time  : ${DateFormat("HH:mm - dd/MM/yyyy").format(task.endTime)}',
                      style: TextStyle(
                          fontSize: 16,
                          color: dark ? Colors.white : CColors.dark),
                    ),
                    SizedBox(
                      height: CSizes.spaceBtwSections,
                    ),
                    Center(
                      child: Obx(() {
                        final iscompleted = taskController.groupTasks.any((t) => t.id == task.id && t.isCompleted).obs;
                        return CButtonAddTask(
                          height: 40,
                          width: 100,
                          color: iscompleted.value
                              ? Colors.green
                              : dark
                              ? CColors.grey.withOpacity(0.4)
                              : CColors.darkGrey,
                          label: iscompleted.value
                              ? "Done"
                              : "Doing",
                          onTap: ()  {
                             taskController.updateTaskCompletion(task.id, !task.isCompleted);
                          },
                        );
                      }),
                    ),
                    SizedBox(
                      height: CSizes.spaceBtwItems,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: CSizes.spaceBtwItems / 2,
              ),
              Text(
                'Comments',
                style: TextStyle(
                  color: dark ? Colors.white : Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              // TextField for new comment
              TextField(
                controller: commentController.contentController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter your comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              ListTile(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    final file = result.files.first;
                    commentController.addDocument(file);
                  }
                },
                leading: const Icon(Icons.attach_file),
                title: const Text('Attach documents'),
              ),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: commentController.documents.map((file) {
                    return Padding(
                      padding: const EdgeInsets.all(1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(file.name)),
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              commentController.removeDocument(file);
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
              ElevatedButton(
                onPressed: () async {
                  if (commentController.selectedComment.value == null) {
                    await commentController.addComment(task.id); // Replace with actual userId
                  } else {
                    await commentController.updateComment(commentController.selectedComment.value!);
                  }
                },
                child: Text(commentController.selectedComment.value == null ? 'Save' : 'Update'),
              ),
              const Divider(),
              SizedBox(height: CSizes.spaceBtwItems / 2),
              Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
                  return CommentTile(comment: comment);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
