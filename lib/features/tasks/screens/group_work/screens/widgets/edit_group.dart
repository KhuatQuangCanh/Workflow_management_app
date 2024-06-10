
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';
import 'package:workflow_management_app/common/widgets/images/circular_images.dart';
import 'package:workflow_management_app/features/personalization/controllers/user_controller.dart';
import 'package:workflow_management_app/features/tasks/controllers/group/group_controller.dart';
import 'package:workflow_management_app/features/tasks/models/group_model.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/add_user.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/attach_document_field.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/widgets/edit_attach_widget.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';


class EditGroupScreen extends StatelessWidget {
final GroupModel group;
final groupController =GroupController.instance;

EditGroupScreen({required this.group}) {
  // Gán giá trị hiện tại của nhóm vào các TextEditingController
  groupController.titleController.text = group.title;
  groupController.descriptionController.text = group.description;
  groupController.locationController.text = group.location;
  groupController.startTime.value = group.startTime;
  groupController.endTime.value = group.endTime;
  groupController.formattedStartTime.value = groupController.formatDateTime(group.startTime);
  groupController.formattedEndTime.value = groupController.formatDateTime(group.endTime);
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Edit Group'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
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
            // const SizedBox(height: CSizes.spaceBtwItems),

            // EditAttachWidget(),
        
            // const SizedBox(height: CSizes.spaceBtwItems),
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
        
            // TextFormField(
            //   readOnly: true,
            //   decoration: const InputDecoration(
            //     icon: Icon(Icons.people_alt_outlined),
            //     hintText: "Add Member",
            //     focusedBorder: InputBorder.none,
            //     enabledBorder: InputBorder.none,
            //     hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
            //     contentPadding: EdgeInsets.symmetric(vertical: 8),
            //   ),
            //   onTap: () {
            //     Get.to(() => AddUserScreen());
            //   },
            // ),
            // Obx(() {
            //   return Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       ...groupController.participants.map((user) => ListTile(
            //         leading: const Icon(Icons.person),
            //         title: Text(user.fullName),
            //         trailing: IconButton(
            //           icon: Icon(Icons.clear),
            //           onPressed: () {
            //             groupController.removeParticipant(user);
            //           },
            //         ),
            //       )).toList(),
            //     ],
            //   );
            // }),
            SizedBox(height: CSizes.spaceBtwSections,),
            ElevatedButton(
              onPressed: () => groupController.updateGroup(group.id),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}