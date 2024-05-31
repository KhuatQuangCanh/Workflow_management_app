import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/common/widgets/texts/section_heading.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/add_group_page.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/group_task_title.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/show_group.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/group/group_controller.dart';
import '../../../models/group_model.dart';
import '../../group_tasks/group_tasks.dart';
import '../../personal_tasks/screens/widgets/button_add_task.dart';

class GroupWorksScreen extends StatelessWidget {
  const GroupWorksScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final groupController = GroupController.instance;
    // final GroupController groupController = Get.find();
    return Scaffold(
      appBar: CAppBar(
        title: Center(
            child: Text(
              'Group work',
              style: TextStyle(fontSize: 24),
            )),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: CSizes.defaultSpace, right: CSizes.defaultSpace, top: CSizes.defaultSpace/2, bottom: CSizes.defaultSpace),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: CHelperFunctions.isDarkMode(context)? Colors.white : Colors.grey),
                      ),
                    ],
                  ),
                ),

                CButtonAddTask(color: CColors.primary,label:"+ Add Group", onTap: () async {
                  await Get.to(() => AddGroupScreen());
                  // await groupController.fetchUserGroups();
                  // controller.getTasks();
                  // controller.titleController.clear();
                  // controller.noteController.clear();
                }
                ),
              ],
            ),
            SizedBox(height: CSizes.spaceBtwItems,),
            CSectionHeading(title: "List of groups", showActionButton: false,),
            SizedBox(height: CSizes.spaceBtwItems,),
            // ShowGroup(),
            Expanded(
              child: Obx(() {
                final List<GroupModel> groups = groupController.allGroups.value;

                if (groups.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (_, index) {
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GroupTasksScreen(group: groups[index]),
                                    ),
                                  );
                                },
                                child: GroupTaskTitle(group: groups[index]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

          ],
        ),
      )

    );
  }
}
