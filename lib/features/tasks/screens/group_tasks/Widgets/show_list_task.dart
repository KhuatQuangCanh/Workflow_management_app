import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/controllers/group_task/task_controller.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/task_detail.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/task_title.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/controllers/user_controller.dart';

class CShowListTask extends StatelessWidget {




  const CShowListTask({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final taskController = TaskController.instance;
    return  Container();
    //   Obx(() {
    //   final groupTasks = taskController.groupTasks;
    //   return ListView.builder(
    //     padding: EdgeInsets.only(top: 10, bottom: CSizes.spaceBtwSections),
    //     shrinkWrap: true,
    //     physics: const NeverScrollableScrollPhysics(),
    //     itemCount: groupTasks.length,
    //     itemBuilder: (context, index) {
    //       final task = groupTasks[index];
    //       return Padding(
    //         padding: const EdgeInsets.only(bottom: CSizes.spaceBtwItems),
    //         child: GestureDetector(
    //           onTap: () => Get.to(() => TaskDetailScreen(task: task)),
    //           child: Stack(
    //             children: [
    //               Container(
    //                 width: 280,
    //                 padding: const EdgeInsets.all(1),
    //                 decoration: BoxDecoration(
    //                   borderRadius:
    //                       BorderRadius.circular(CSizes.productImageRadius),
    //                   color: task.isCompleted
    //                       ? Colors.green.withOpacity(0.5)
    //                       : dark
    //                           ? CColors.darkerGrey
    //                           : CColors.softGrey,
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(
    //                       left: CSizes.md, right: CSizes.md, top: CSizes.sm),
    //                   child: Row(
    //                     children: [
    //                       CYourTasksHorizontal(task: task),
    //                       Checkbox(
    //                         value: task.isCompleted,
    //                         onChanged: (bool? value) {
    //                           // if (value != null) {
    //                           //   taskController.updateTaskCompletion(
    //                           //       task.id, value);
    //                           //   taskController.update();
    //                           // }
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 0,
    //                 right: 0,
    //                 child: GestureDetector(
    //                   onTap: () async {
    //                       // Hiển thị thông báo xác nhận
    //                       final result = await showDialog(
    //                         context: context,
    //                         builder: (BuildContext context) {
    //                           return AlertDialog(
    //                             title: Text('Confirm Delete'),
    //                             content: Text('Are you sure you want to delete this task?'),
    //                             actions: [
    //                               TextButton(
    //                                 child: Text('No'),
    //                                 onPressed: () {
    //                                   Navigator.of(context).pop(false); // Trả về false
    //                                 },
    //                               ),
    //                               TextButton(
    //                                 child: Text('Yes'),
    //                                 onPressed: () {
    //                                   Navigator.of(context).pop(true); // Trả về true
    //                                 },
    //                               ),
    //                             ],
    //                           );
    //                         },
    //                       );
    //
    //                       // Kiểm tra kết quả từ hộp thoại xác nhận
    //                       if (result == true) {
    //                         await taskController.deleteTask(task.id);
    //                       }
    //                   },
    //                   child: Container(
    //                     width: 30,
    //                     height: 30,
    //                     padding: EdgeInsets.all(8),
    //                     decoration: BoxDecoration(
    //                       shape: BoxShape.circle,
    //                     ),
    //                     child: Icon(Icons.delete, color: Colors.red),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // });
  }
}
