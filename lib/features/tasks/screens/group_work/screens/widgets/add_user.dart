import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/group/group_controller.dart';


class AddUserScreen extends StatelessWidget {
  final groupController = GroupController.instance;

  AddUserScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Participant'),
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
                  groupController.addParticipant(user);
                  Get.snackbar("Success", "${user.fullName} added as  participant ");
                  Get.back();
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
                final users = groupController.participants ;
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
                          groupController.removeParticipant(user);
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

