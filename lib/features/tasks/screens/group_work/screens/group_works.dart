import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/common/widgets/texts/section_heading.dart';
import 'package:workflow_management_app/features/personalization/controllers/user_controller.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/add_group_page.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/group_task_title.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/show_group.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/group/group_controller.dart';
import '../../../controllers/group_task/task_controller.dart';
import '../../../models/group_model.dart';
import '../../group_tasks/group_detail.dart';
import '../../personal_tasks/screens/widgets/button_add_task.dart';

class GroupWorksScreen extends StatelessWidget {
  const GroupWorksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GroupController groupController = Get.put(GroupController());
    // Không cần lấy allGroups ở đây, nó sẽ tự động cập nhật thông qua Obx
    return Scaffold(
        appBar: CAppBar(
          title: Text(
            'List of Groups',
            style: TextStyle(fontSize: 26),
          ),
          actions: [
            CButtonAddTask(
              color: CColors.primary,
              label: "+ Add Group",
              onTap: () async {
                groupController.clearFields();
                await Get.to(() => AddGroupScreen());
              },
            ),
          ],
        ),
        body:
        Padding(
          padding: EdgeInsets.only(
              left: CSizes.defaultSpace,
              right: CSizes.defaultSpace,
              top: CSizes.defaultSpace / 2,
              bottom: CSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              ShowGroup()

            ],
          ),
        )
    );
  }
}
