import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:workflow_management_app/common/widgets/texts/section_heading.dart';
import 'package:workflow_management_app/features/tasks/controllers/group/group_controller.dart';
import 'package:workflow_management_app/features/tasks/controllers/group_task/task_controller.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/add_task.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/edit_member.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/task_detail.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/task_title.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/edit_group.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/group_model.dart';
import '../personal_tasks/screens/widgets/button_add_task.dart';

class GroupDetailScreen extends StatefulWidget {
  const GroupDetailScreen({super.key, required this.group});

  final GroupModel group;

  @override
  _GroupDetailScreenState createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final groupController = GroupController.instance;
  final taskController = TaskController.instance;

  @override
  void initState() {
    super.initState();
    groupController.fetchGroupParticipantsCount(widget.group.id);
    taskController.fetchTasksByGroupId(widget.group.id);
    taskController.fetchUserTasksInGroup(widget.group.id);
  }

  @override
  Widget build(BuildContext context) {
    final attachmentUrls = widget.group.attachmentUrls.take(5).toList();
    final attachmentNames = attachmentUrls
        .map((url) => Uri.decodeFull(url).split('/').last.split('?').first)
        .toList();

    final dark = CHelperFunctions.isDarkMode(context);
    final screenWidth = MediaQuery.of(context).size.width*0.87;
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                CPrimaryHeaderContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CAppBar(
                        title: const Text('Group Detail',
                            style: TextStyle(fontSize: 24)),
                        showBackArrow: true,
                        actions: [
                          IconButton(
                            onPressed: () {
                              // if (widget.group.ownerId == userId || widget.group.managerIds.contains(userId)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Group Options"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.edit,
                                              color: CColors.primary,
                                            ),
                                            title: Text(
                                              'Edit Group',
                                              style: TextStyle(
                                                  color: CColors.primary),
                                            ),
                                            onTap: () {
                                              Get.to(() => EditGroupScreen(
                                                  group: widget.group));
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.delete,
                                              color: CColors.primary,
                                            ),
                                            title: Text(
                                              'Delete Group',
                                              style: TextStyle(
                                                  color: CColors.primary),
                                            ),
                                            onTap: () async {
                                              final result = await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('Confirm Delete'),
                                                    content: Text(
                                                        'Are you sure you want to delete this task?'),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop(
                                                              false); // Trả về false
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Yes'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop(
                                                              true); // Trả về true
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              if (result == true) {
                                                // await groupController.deleteGroupAndTasks(widget.group.id);
                                              } else {
                                                Navigator.of(context).pop();
                                              }

                                              Navigator.of(context)
                                                  .pop(); // Đóng AlertDialog
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(Iconsax.edit, color: Colors.white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: CSizes.defaultSpace,
                          right: CSizes.defaultSpace,
                          left: CSizes.defaultSpace,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.group.title,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            const SizedBox(height: CSizes.spaceBtwItems / 2),
                            Text(widget.group.description,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            const SizedBox(height: CSizes.spaceBtwItems / 2),
                            Row(children: [
                              const Icon(Icons.location_on_outlined,
                                  color: Colors.white),
                              const SizedBox(width: 4),
                              Text(widget.group.location,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ]),
                            const SizedBox(height: CSizes.spaceBtwItems / 2),
                            Row(children: [
                              const Icon(Icons.access_time_rounded,
                                  color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                  'Start Time: ${DateFormat("dd/MM/yyyy - HH:mm").format(widget.group.startTime)}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: Text(
                                  'End Time: ${DateFormat("dd/MM/yyyy - HH:mm").format(widget.group.endTime)}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                            const SizedBox(height: CSizes.spaceBtwItems / 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: attachmentNames.map((fileName) {
                                final fileIndex =
                                    attachmentNames.indexOf(fileName);
                                final fileUrl = attachmentUrls[fileIndex];
                                return GestureDetector(
                                  onTap: () async {
                                    final url = fileUrl.replaceAll(' ', '%2F');
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Could not launch $url')),
                                      );
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.insert_drive_file,
                                                color: Colors.white),
                                            const SizedBox(width: 8),
                                            Text(_truncateFileName(fileName),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white)),
                                          ]),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await groupController.fetchGroupParticipants(widget.group.id);
                                    _showParticipantsDialog(context, widget.group, groupController);
                                  },
                                  icon: Icon(Icons.people_alt_outlined,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 4),
                                Text('${groupController.participantsCount}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CSectionHeading(
                            title: 'Your tasks:', showActionButton: false),
                        SizedBox(height: CSizes.spaceBtwItems/2,),
                        SizedBox(
                          height: 120,
                          child: Obx(() {
                            final userTasks = taskController.userTasks;
                            if(userTasks.isEmpty) {
                              return Center(child: Text("No tasks assigned to you in this group."),);
                            }
                            else {
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(width: CSizes.spaceBtwItems),
                                itemCount: userTasks.length,
                                itemBuilder: (context, index) {
                                  final task = userTasks[index];
                                  double taskWidth = userTasks.length == 1 ? screenWidth : 280; // Điều chỉnh chiều rộng của mục
                                  return GestureDetector(
                                    onTap: () => Get.to(() => TaskDetailScreen(task: task)),
                                    child: Container(
                                      width: taskWidth,
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(CSizes.productImageRadius),
                                        color: task.isCompleted ? Colors.green.withOpacity(0.5) : dark ? CColors.darkerGrey : CColors.softGrey,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: CSizes.md, right: CSizes.md, top: CSizes.sm),
                                        child: CYourTasksHorizontal(task: task),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }


                          }),
                        ),
                        const SizedBox(height: CSizes.spaceBtwItems),
                        const CSectionHeading(
                            title: 'List of tasks:', showActionButton: false),
                        SizedBox(height: CSizes.spaceBtwItems/2,),
                        Obx(() {
                          final groupTasks = taskController.groupTasks;
                          return ListView.builder(
                            padding: EdgeInsets.only(
                                bottom: CSizes.spaceBtwSections),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: groupTasks.length,
                            itemBuilder: (context, index) {
                              final task = groupTasks[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: CSizes.spaceBtwItems),
                                child: GestureDetector(
                                  onTap: () => Get.to(
                                      () => TaskDetailScreen(task: task)),
                                  child: Container(
                                    width: screenWidth,
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          CSizes.productImageRadius),
                                      color: task.isCompleted
                                          ? Colors.green.withOpacity(0.5)
                                          : dark
                                              ? CColors.darkerGrey
                                              : CColors.softGrey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: CSizes.md,
                                          right: CSizes.md,
                                          top: CSizes.sm),
                                      child: CYourTasksHorizontal(task: task),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: CButtonAddTask(
                color: CColors.primary,
                label: "+ Add Task",
                onTap: () async {
                  await Get.to(
                      () => AddGroupTaskScreen(groupId: widget.group.id));
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  String _truncateFileName(String fileName, {int maxLength = 30}) {
    return fileName.length <= maxLength
        ? fileName
        : fileName.substring(0, maxLength - 3) + '...';
  }
  void _showParticipantsDialog(BuildContext context, GroupModel group, GroupController groupController) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Members :'),
          content: Obx(() {
            return SingleChildScrollView(
              child: ListBody(
                children: [
                  ...groupController.getparticipants.map((user) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(user.fullName),
                  )).toList(),
                  if (groupController.isCreator.value)
                    ListTile(
                      leading: Icon(Icons.edit, color: CColors.primary),
                      title: Text('Edit Member', style: TextStyle(color: CColors.primary)),
                      onTap: () {
                        Navigator.of(context).pop(); // Đóng AlertDialog
                        Get.to(() => EditMemberScreen(group: group));
                      },
                    ),
                ],
              ),
            );
          }),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

