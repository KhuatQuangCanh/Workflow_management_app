import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';
import '../../../controllers/group_task/task_controller.dart';
import '../../../models/task_model.dart';

class CYourTasksHorizontal extends StatefulWidget {
  final TaskModel task;

  const CYourTasksHorizontal({Key? key, required this.task}) : super(key: key);

  @override
  State<CYourTasksHorizontal> createState() => _CYourTasksHorizontalState();
}

class _CYourTasksHorizontalState extends State<CYourTasksHorizontal> {
  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    // final TaskController taskController = TaskController.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start: ${DateFormat("dd/MM/yyyy HH:mm").format(widget.task.startTime)}',
              style: TextStyle(
                fontSize: 14,
                color: dark ? Colors.white54 : Colors.black54,
              ),
            ),
            Text(
              'End  : ${DateFormat("dd/MM/yyyy HH:mm").format(widget.task.endTime)}',
              style: TextStyle(
                fontSize: 14,
                color: dark ? Colors.white54 : Colors.black54,
              ),
            ),
            SizedBox(height: CSizes.spaceBtwItems,)
          ],
        ),
    PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              // commentController.selectComment(comment);
            } else if (value == 'delete') {
              // commentController.deleteComment(comment.id);
            }
          },
          itemBuilder: (context) => [
            // if (comment.userId == userId) // Kiểm tra xem người dùng hiện tại có phải là người tạo comment không
              PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
            // if (comment.userId == userId) // Kiểm tra xem người dùng hiện tại có phải là người tạo comment không
              PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
          ],
          icon: Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
