import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/personalization/controllers/user_controller.dart';
import 'package:workflow_management_app/features/tasks/controllers/group/group_controller.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/group_detail.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/add_user.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/attach_document_field.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/images/circular_images.dart';
import '../../../../../../utils/constants/image_strings.dart';

class AddGroupScreen extends StatelessWidget {
  const AddGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupController = GroupController.instance;
    final userController = UserController.instance;
    return Scaffold(
      appBar: const CAppBar(
        title: Text('Add group'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.sm),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const CCircularImage(
                    image: CImages.user,
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Creator: ", style: Theme.of(context).textTheme.titleSmall),
                      Text(userController.user.value.fullName, style: Theme.of(context).textTheme.titleSmall)
                    ],
                  )
                ],
              ),
              const Divider(),

              TextFormField(
                autofocus: false,
                controller: groupController.titleController,
                maxLines: 1,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                  hintText: "Add title",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
              ),
              const Divider(),

              TextFormField(
                autofocus: false,
                controller: groupController.descriptionController,
                maxLines: null,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                  icon: Icon(Icons.menu_outlined),
                  hintText: "Add description",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwItems),

              AttachDocumentField(),

              const SizedBox(height: CSizes.spaceBtwItems),
              const Divider(),

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
                                onPressed: () => groupController.pickStartTime(context),
                                child: Text(
                                  'Start Time: ${groupController.formattedStartTime.value}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () => groupController.pickEndTime(context),
                                child: Text(
                                  'End Time: ${groupController.formattedEndTime.value}',
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

              TextFormField(
                autofocus: false,
                controller: groupController.locationController,
                maxLines: null,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                  icon: Icon(Icons.location_on_outlined),
                  hintText: "Location",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const Divider(),

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
                  Get.to(() => AddUserScreen());
                },
              ),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...groupController.participants.map((user) => ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(user.fullName),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          groupController.removeParticipant(user);
                        },
                      ),
                    )).toList(),
                  ],
                );
              }),
              const Divider(),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.all(CSizes.defaultSpace),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      await groupController.createGroup();
                      Get.back();
                    },
                    child: const Text("Create group"),
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
