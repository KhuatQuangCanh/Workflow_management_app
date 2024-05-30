import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../../../../../common/widgets/notified/notified_page.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../personal_tasks/controllers/personal_tasks_controller.dart';
import '../../../personal_tasks/models/personal_task.dart';

class PersonalTaskTitle extends StatelessWidget {
  final PersonalTask? task;

  PersonalTaskTitle(this.task);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalTasksController());
    final dark = CHelperFunctions.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.only(
          left: CSizes.sm, right: CSizes.sm, bottom: CSizes.spaceBtwItems),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -- Title
                Text(
                  task?.title ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: CSizes.spaceBtwItems / 4,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: CColors.darkGrey,
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${task!.startTime} - ${task!.endTime}",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 13, color: CColors.darkGrey),
                          ),
                        ),
                      ],
                    ),

                    // Sử dụng GestureDetector thay vì TextButton
                    GestureDetector(
                      onTap: () {
                        navigateToNotifiedPage(context, task);
                      },
                      child: Row(
                        children: [
                          Text(
                            "View task",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: CColors.primary),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Iconsax.eye,
                            color: CColors.primary,
                            size: 18,
                          ),
                        ],
                      ),
                    ),



                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            width: 4,
            color: _getBGClr(task?.color ?? 0),
          ),

          GestureDetector(
            onTap: () {
              controller.markTaskCompleted(task!.id);
            },
            child: Image(width: 25, height: 25, image: AssetImage(CImages.added)),
          )
        ],
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Colors.green.withOpacity(0.8);
      case 1:
        return Colors.orangeAccent.withOpacity(0.8);
      case 2:
        return Colors.red.withOpacity(0.8);
      default:
        return Colors.green.withOpacity(0.8);
    }
  }

  // Phương thức điều hướng tới NotifiedPage
  void navigateToNotifiedPage(BuildContext context, PersonalTask? task) {
    String label = "${task?.title}|${task?.note}|";
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotifiedPage(label: label)),
    );
  }
}
