import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/group_detail.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';

import '../../../../controllers/group/group_controller.dart';
import '../../../../models/group_model.dart';
import 'group_task_title.dart';

class ShowGroup extends StatelessWidget {
  const ShowGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final groupController = GroupController.instance;
    return Expanded(
      child: Obx(() {
        if (groupController.userGroups.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You are not participating in any events", style: Theme.of(context).textTheme.titleSmall,),
                Image(image: AssetImage(CImages.staticSuccessTllustration)),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: groupController.userGroups.length,
          itemBuilder: (context, index) {
            final group = groupController.userGroups[index];
            return GestureDetector(
              onTap: () => Get.to(() => GroupDetailScreen(group: group)),
              child: GroupTaskTitle(group: group),
            );
          },
        );
      }),
    );
  }
}
