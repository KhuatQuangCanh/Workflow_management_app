import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/features/tasks/controllers/group_task/task_controller.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/member_selection.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/add_user.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';

class AddGroupTaskScreen extends StatelessWidget {
  final String groupId;

  const AddGroupTaskScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = TaskController.instance;

    return Scaffold(
      appBar: const CAppBar(
        title: Text('Add tasks to the group'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.sm),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // -- Title
              TextFormField(
                controller: taskController.titleController,
                maxLines: null,
                minLines: 1,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                  hintText: "Add title",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
              ),

              const Divider(),
              // -- Add Description
              TextFormField(
                controller: taskController.descriptionController,
                maxLines: null,
                minLines: 1,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                  icon: Icon(Icons.menu_outlined),
                  hintText: "Add description",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.people_alt_outlined),
                  hintText: "Add Participant",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                onTap: () {
                  Get.to(() => MemberSelectionScreen());
                },
              ),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...taskController.participants.map((user) => ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(user.fullName),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          taskController.removeParticipant(user);
                        },
                      ),
                    )).toList(),
                  ],
                );
              }),


              // -- Assign Participants
              // ParticipantSelectionField(),


              const Divider(),

              // -- Start Time, End Time
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded),
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () => taskController.pickStartTime(context),
                                child: Text(
                                  'Start Time: ${taskController.formattedStartTime.value}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () => taskController.pickEndTime(context),
                                child: Text(
                                  'End Time: ${taskController.formattedEndTime.value}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(),

              // Notification Minutes Before
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Iconsax.notification),
                        SizedBox(width: 14),
                        Text(
                          'Notification Before:',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                        ),
                        SizedBox(width: CSizes.spaceBtwItems),
                        Obx(() => DropdownButton<int>(
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                          value: taskController.notificationMinutesBefore.value,
                          items: [
                            if (taskController.notificationMinutesBefore.value == 5) DropdownMenuItem(value: 5, child: Text('5 minutes')),
                            DropdownMenuItem(value: 10, child: Text('10 minutes')),
                            DropdownMenuItem(value: 15, child: Text('15 minutes')),
                            DropdownMenuItem(value: 30, child: Text('30 minutes')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              taskController.notificationMinutesBefore.value = value;
                            }
                          },
                        )),
                      ],
                    ),

                  ],
                ),
              ),

              const Divider(),

              Padding(
                padding: const EdgeInsets.all(CSizes.defaultSpace),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      await taskController.createAndSaveTask(groupId);
                    },
                    child: const Text("Add task"),
                  ),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
