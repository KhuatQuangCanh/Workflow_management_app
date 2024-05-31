import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:workflow_management_app/features/tasks/controllers/group/group_controller.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

class AttachDocumentField extends StatelessWidget {
  final GroupController controller = Get.find<GroupController>();

  AttachDocumentField({Key? key}) : super(key: key);

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
            children: controller.documents.map((file) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: CSizes.defaultSpace / 2),
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
          );
        }),
      ],
    );
  }
}