import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:workflow_management_app/common/widgets/texts/section_heading.dart';
import 'package:workflow_management_app/features/tasks/controllers/group/group_controller.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/add_group_task.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/your_task.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../models/group_model.dart';
import '../group_work/screens/widgets/attach_document_field.dart';
import '../personal_tasks/screens/widgets/add_task_page.dart';
import '../personal_tasks/screens/widgets/button_add_task.dart';
class GroupTasksScreen extends StatefulWidget {
  const GroupTasksScreen({Key? key, required this.group}) : super(key: key);
  final GroupModel group;

  @override
  _GroupTasksScreenState createState() => _GroupTasksScreenState();
}

class _GroupTasksScreenState extends State<GroupTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final attachmentUrls = widget.group.attachmentUrls.take(5).toList();
    final attachmentNames = getFileNamesFromUrls(attachmentUrls);
    final userController = UserController.instance;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // - Header
              CPrimaryHeaderContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CAppBar(
                      title: const Text(
                        'Group Tasks',
                        style: TextStyle(fontSize: 24),
                      ),
                      showBackArrow: true,
                      actions: [
                        IconButton(
                          onPressed: () {
                            Get.offAll(() => const NavigationMenu());
                          },
                          icon: const Icon(Icons.home_outlined, color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: CSizes.defaultSpace,
                        right: CSizes.defaultSpace,
                        bottom: CSizes.spaceBtwSections,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.group.title}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: CSizes.spaceBtwItems / 2,
                          ),
                          Text(
                            '${widget.group.description}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: CSizes.spaceBtwItems / 2,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${widget.group.location}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: CSizes.spaceBtwItems / 2,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Start Time: ${DateFormat("dd/MM/yyyy - HH:mm").format(widget.group.startTime)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: Text(
                              'End Time: ${DateFormat("dd/MM/yyyy - HH:mm").format(widget.group.endTime)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: CSizes.spaceBtwItems / 2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Phần hiển thị tên tệp
                              Wrap(
                                children: attachmentNames.map((fileName) {
                                  final fileIndex = attachmentNames.indexOf(fileName);
                                  final fileUrl = attachmentUrls[fileIndex];
                                  return GestureDetector(
                                    onTap: () async {
                                      final url = fileUrl.replaceAll(' ', '%2F');
                                      print(url);
                                      print(fileUrl);
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Could not launch $url'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.insert_drive_file, color: Colors.white),
                                            const SizedBox(width: 8),
                                            Text(
                                              _truncateFileName(fileName),
                                              style: const TextStyle(fontSize: 14, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: CSizes.spaceBtwItems / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${widget.group.memberIds.length}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "Completed : 7/10",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
                    child: Column(
                      children: [
                        CSectionHeading(
                          title: 'Your tasks',
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => const SizedBox(
                              width: CSizes.spaceBtwItems,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index) => const CYourTasksHorizontal(),
                          ),
                        ),
                        const SizedBox(
                          height: CSizes.spaceBtwItems,
                        ),
                        const CSectionHeading(
                          title: 'Group tasks',
                          showActionButton: false,
                        ),
                      ],
                    ),
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
                // Check if the current user is the owner or manager
                final userId = userController.user.value.id; // Lấy userId từ session hoặc userController
                final isOwner = widget.group.ownerId == userId;
                final isManager = widget.group.managerIds.contains(userId);

                if (isOwner || isManager) {
                  await Get.to(() => AddGroupTaskScreen(groupId: widget.group.id));
                } else {
                  // Show an error or warning message
                  Get.snackbar("Access Denied", "You don't have permission to add tasks to this group.");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _truncateFileName(String fileName, {int maxLength = 30}) {
    if (fileName.length <= maxLength) {
      return fileName;
    } else {
      return fileName.substring(0, maxLength - 3) + '...';
    }
  }
}

List<String> getFileNamesFromUrls(List<String> urls) {
  return urls.map((url) => Uri.decodeFull(url).split('/').last.split('?').first).toList();
}
