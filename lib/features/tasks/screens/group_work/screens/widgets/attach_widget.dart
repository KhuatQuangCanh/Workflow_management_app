import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AttachmentWidget extends StatelessWidget {
  final List<String> attachmentNames; // Danh sách tên tệp đính kèm
  final List<String> attachmentUrls;  // Danh sách URL của tệp đính kèm

  AttachmentWidget({
    required this.attachmentNames,
    required this.attachmentUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: List.generate(attachmentNames.length, (index) {
            return GestureDetector(
              onTap: () async {
                final url = attachmentUrls[index];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.insert_drive_file),
                  SizedBox(width: 8),
                  Text(
                    _truncateFileName(attachmentNames[index]),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
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
