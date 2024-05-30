import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/models/personal_task.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/task_title.dart';
import 'package:workflow_management_app/services/notification_services.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../controllers/personal_tasks_controller.dart';

class ShowTasks extends StatelessWidget {
  const ShowTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalTasksController());

    return Obx(() {
      controller.sortTime();
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
              DateTime date = DateFormat("HH:mm").parse(task.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);

              // Tạo thông báo lên thiết bị
              NotifyHelper().scheduledNotification(
                int.parse(myTime.split(":")[0]),
                int.parse(myTime.split(":")[1]),
                task,
              );

              return AnimationConfiguration.staggeredList(
                duration: Duration(milliseconds: 100),
                position: index,
                child: SlideAnimation(
                  horizontalOffset: 100,
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _ShowBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      );
    });

  }

  _ShowBottomSheet(BuildContext context, PersonalTask task) {
    final controller = Get.put(PersonalTasksController());
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color:
          CHelperFunctions.isDarkMode(context) ? CColors.dark : CColors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CHelperFunctions.isDarkMode(context)
                  ? Colors.grey[600]
                  : Colors.grey[500],
            ),
          ),
          // SizedBox(height: CSizes.spaceBtwItems,),

          Spacer(),
          // Task Completed button
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    controller.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: CColors.primary,
                  context: context,
                ),
          _bottomSheetButton(
            label: "Delete Task",
            onTap: () {
              controller.delete(task);
              Get.back();
            },
            clr: Colors.red.withOpacity(0.8),
            context: context,
          ),
          SizedBox(
            height: CSizes.spaceBtwItems,
          ),

          _bottomSheetButton(
            label: "Close",
            onTap: () {
              Get.back();
            },
            clr: CHelperFunctions.isDarkMode(context)
                ? CColors.white
                : CColors.grey,
            isClose: true,
            context: context,
          ),
          SizedBox(
            height: CSizes.spaceBtwItems / 2,
          )
        ],
      ),
    ));
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
            top: CSizes.defaultSpace / 1.5,
            left: CSizes.defaultSpace,
            right: CSizes.defaultSpace),
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              color: clr,
              border: Border.all(width: 2, color: clr),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              label,
              style: isClose
                  ? TextStyle(fontSize: 16, color: CColors.dark)
                  : TextStyle(fontSize: 16, color: CColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
