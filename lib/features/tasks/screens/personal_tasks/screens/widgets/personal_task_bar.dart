import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/add_task_page.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/button_add_task.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../controllers/personal_tasks_controller.dart';

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalTasksController());

    return Padding(
      padding: const EdgeInsets.only(left: CSizes.defaultSpace, right: CSizes.defaultSpace, ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: CSizes.spaceBtwItems /2,),
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: CHelperFunctions.isDarkMode(context)? Colors.white : Colors.grey),
                ),
              ],
            ),
          ),

          CButtonAddTask(color: CColors.grey.withOpacity(0.4),label:"+ Add Task", onTap: () async {
            await Get.to(const AddTaskScreen());
            controller.getTasks();
            controller.titleController.clear();
            controller.noteController.clear();
          }
          ),
        ],
      ),
    );
  }
}
