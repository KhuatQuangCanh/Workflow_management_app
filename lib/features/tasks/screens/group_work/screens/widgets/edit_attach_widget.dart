import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workflow_management_app/features/tasks/controllers/group/group_controller.dart';

class EditAttachWidget extends StatelessWidget {
  final controller = GroupController.instance;

  EditAttachWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              final file = result.files.first;
              controller.addDocument(file);
            }
          },
          leading: const Icon(Icons.attach_file),
          title: const Text('Attach documents'),
        ),
        Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị các tệp cũ
              ...controller.attachmentUrls.map((url) {
                final fileName = Uri.decodeFull(url).split('/').last.split('?').first;
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(fileName)),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.removeAttachmentUrl(url);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
              // Hiển thị các tệp mới
              ...controller.documents.map((file) {
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(file.name)),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.removeDocument(file);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }),
      ],
    );
  }
}
