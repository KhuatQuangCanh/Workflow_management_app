import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/personal_task_bar.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/button_add_task.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/personal_task_date_bar.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/widgets/show_tasks.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';

class PersonalTasksScreen extends StatelessWidget {
  const PersonalTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CPrimaryHeaderContainer(
            child: Column(
              children: [
                // AppBar
                CAppBar(
                  title: Center(
                      child: Text(
                    'Personal Tasks',
                    style: TextStyle(fontSize: 24),
                  )),
                ),

                AddTaskBar(),
                SizedBox(height: CSizes.spaceBtwItems/2,),


                AddDateBar(),
                SizedBox(height: CSizes.spaceBtwSections,)
              ],
            ),
          ),
          // --Show Tasks

          ShowTasks(),

        ],
      ),

    );
  }
}
