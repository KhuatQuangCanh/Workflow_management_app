import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/input_field.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/selected_color.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../controllers/home_controller.dart';
import '../../controllers/personal_tasks_controller.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalTasksController());

    List<int> remindList = [5, 10, 15, 30,];
    List<String> repeatList = ["None", "Daily"];

    return Scaffold(
        appBar: const CAppBar(
          title: Text('Add Task'),
          showBackArrow: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(CSizes.defaultSpace),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Title
                  CInputField(title: 'Title :', hint: 'Enter title here.', controller: controller.titleController,),
                  const SizedBox(
                    height: CSizes.spaceBtwItems,
                  ),

                  // Note
                  CInputField(title: 'Note :', hint: 'Enter title here.', controller: controller.noteController,),
                  const SizedBox(
                    height: CSizes.spaceBtwItems,
                  ),

                  // Date
                  Obx(
                    () => CInputField(
                      title: 'Date :',
                      hint: DateFormat("dd/MM/yyyy")
                          .format(controller.selectedDate.value)
                          .toString(),
                      widget: IconButton(
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () => PersonalTasksController.instance
                              .getDateFromUser()),
                    ),
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtwItems,
                  ),

                  // Start Time , End Time
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => CInputField(
                              title: "Start Time: ",
                              hint: controller.startTime.value,
                              widget: IconButton(
                                  onPressed: () => PersonalTasksController
                                      .instance
                                      .getTimeFromUser(isStartTime: true),
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  )),
                            )),
                      ),
                      const SizedBox(
                        width: CSizes.spaceBtwItems,
                      ),
                      Expanded(
                        child: Obx(() => CInputField(
                              title: "End Time: ",
                              hint: controller.endTime.value,
                              widget: IconButton(
                                  onPressed: () => PersonalTasksController
                                      .instance
                                      .getTimeFromUser(isStartTime: false),
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  )),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtwItems,
                  ),

                  // --Remind
                  Obx(
                    () => CInputField(
                      title: "Remind: ",
                      hint: "${controller.selectedRemind.value} minutes early",
                      widget: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: DropdownButton<String>(
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey),
                          iconSize: 32,
                          elevation: 4,
                          underline: Container(height: 0),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.updateRemind(int.parse(newValue));
                            }
                          },
                          items: remindList
                              .map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtwItems,
                  ),


                  // --Repeat
                  Obx(
                        () => CInputField(
                      title: "Repeat: ",
                      hint: "${controller.selectedRepeat.value} ",
                      widget: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: DropdownButton<String>(
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey),
                          iconSize: 32,
                          elevation: 4,
                          underline: Container(height: 0),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.updateRepeat(newValue);
                            }
                          },
                          items: repeatList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),

                  // --Colors , Button Create Task
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CSelectedColor(),
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () => controller.validateData(), child: const Text("Create Task")),
                      )

                    ],
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),


                ],
              ),
            ),
        ),
    );


  }




}

