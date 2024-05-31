import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/group_task_title.dart';

import '../../../../controllers/group/group_controller.dart';
import '../../../../models/group_model.dart';
import '../../../group_tasks/group_tasks.dart';

class ShowGroup extends StatelessWidget {
  const ShowGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final groupController = GroupController.instance;
    return Obx(() {
      final List<GroupModel> groups = groupController.allGroups.value;

      if (groups.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return Expanded(
        child: ListView.builder(
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
        ),
      );
    });
  }
}

