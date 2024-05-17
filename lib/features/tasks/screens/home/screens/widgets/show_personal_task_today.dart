import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/features/tasks/screens/home/screens/widgets/personal_task_title.dart';

import '../../../personal_tasks/controllers/personal_tasks_controller.dart';
import '../../../personal_tasks/models/task.dart';

class ShowPersonalTaskToday extends StatelessWidget {
  const ShowPersonalTaskToday({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalTasksController());

    return Obx(() {
      return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
              itemCount: controller.taskList.length,
              itemBuilder: (_, index) {
                PersonalTask task = controller.taskList[index];

                if (task.repeat == 'Daily' ||
                    task.date ==
                        DateFormat("dd/MM/yyyy")
                            .format(controller.selectedDate.value)) {

                  return  PersonalTaskTitle(task);
                  // return AnimationConfiguration.staggeredList(
                  //   position: index,
                  //   child: SlideAnimation(
                  //     horizontalOffset: 300,
                  //     child: FadeInAnimation(
                  //       child: Row(
                  //         children: [
                  //           PersonalTaskTitle(task),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                } else {
                  return Container( color: Colors.red,);
                }
              }
          )
      );
    });
  }
}
