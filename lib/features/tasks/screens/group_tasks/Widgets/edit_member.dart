
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/controllers/group/group_controller.dart';
import 'package:workflow_management_app/features/tasks/controllers/group_task/task_controller.dart';
import 'package:workflow_management_app/features/tasks/models/group_model.dart';

import '../../../../personalization/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMemberScreen extends StatelessWidget {
  final GroupController groupController = GroupController.instance;
  final GroupModel group;

  EditMemberScreen({required this.group});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Members'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Enter phone number',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final phoneNumber = phoneController.text.trim();
                final user = await groupController.searchUserByPhoneNumber(phoneNumber);

                if (user != null) {
                  groupController.addMember(user);
                  Get.snackbar("Success", "${user.fullName} added as participant");
                } else {
                  Get.snackbar("Error", "User not found");
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Add Participant',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final users = groupController.getparticipants;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(user.fullName),
                      trailing: user.id != groupController.UserId
                          ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          groupController.removeMember(user);
                        },
                      )
                          : null, // Nếu là 'creator', không hiển thị nút remove
                    );
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                groupController.updateMember(group.id);
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Save Changes',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
