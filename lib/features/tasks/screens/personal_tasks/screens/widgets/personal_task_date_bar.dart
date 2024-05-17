import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../controllers/personal_tasks_controller.dart';

class AddDateBar extends StatelessWidget {
  const AddDateBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalTasksController());

    return Obx(() =>  Container(
      margin: EdgeInsets.only(left: 7),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: controller.selectedDate.value,
        selectionColor: CColors.grey.withOpacity(0.4),
        selectedTextColor: CColors.white,
        dateTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white ,
        ),
        dayTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        monthTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),

        onDateChange: (date) {
          controller.selectedDate.value = date;
          controller.getTasks();
        },
      ),
    ));
  }
}
