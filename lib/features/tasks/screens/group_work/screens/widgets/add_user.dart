import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/group/group_controller.dart';

// enum UserType { participant, manager }

class AddUserScreen extends StatelessWidget {
  final UserType userType;
  final GroupController controller = Get.find<GroupController>();

  AddUserScreen({required this.userType});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(userType == UserType.participant ? 'Add Participant' : 'Add Manager'),
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
                final user = await controller.searchUserByPhoneNumber(phoneNumber);

                if (user != null) {
                  if (userType == UserType.participant) {
                    controller.addParticipant(user);
                  } else {
                    controller.addManager(user);
                  }
                  Get.snackbar("Success", "${user.fullName} added as ${userType == UserType.participant ? 'participant' : 'manager'}");
                  Get.back();
                } else {
                  Get.snackbar("Error", "User not found");
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Add ${userType == UserType.participant ? 'Participant' : 'Manager'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final users = userType == UserType.participant ? controller.participants : controller.managers;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(user.fullName),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          if (userType == UserType.participant) {
                            controller.removeParticipant(user); // Sửa lại thành user.id
                          } else {
                            controller.removeManager(user); // Sửa lại thành user.id
                          }
                        },
                      ),

                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

