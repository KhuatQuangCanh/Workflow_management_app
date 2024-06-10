import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workflow_management_app/common/widgets/images/circular_images.dart';
import 'package:workflow_management_app/features/personalization/models/user_model.dart';
import 'package:workflow_management_app/features/tasks/controllers/comment/comment_controller.dart';
import 'package:workflow_management_app/features/tasks/models/comment_model.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../../../personalization/controllers/user_controller.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;

  const CommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final commentController = CommentController.instance;
    commentController.fetchCommentUser(comment.userId);
    final attachmentNames = comment.attachmentUrls
        .map((url) => Uri.decodeFull(url).split('/').last.split('?').first)
        .toList();
  return Obx( () {
    final user = commentController.commentUser.value;
    final networkImage = user?.profilePicture?? CImages.user;
    // final image = networkImage.isNotEmpty? networkImage: CImages.user;
   return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: dark ? CColors.darkGrey : Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [

                CCircularImage(image: networkImage, width: 50, height: 50,isNetworkImage: networkImage.isNotEmpty,),

                  const SizedBox(
                    width: CSizes.spaceBtwItems,
                  ),
                  Text(
                    user?.fullName?? 'Unknown User' , // Replace with actual username
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'edit') {
                    commentController.selectComment(comment);
                  } else if (value == 'delete') {
                    commentController.deleteComment(comment.id);
                  }
                },
                itemBuilder: (context) => [
                  if (comment.userId == commentController.UserId) // Kiểm tra xem người dùng hiện tại có phải là người tạo comment không
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                  if (comment.userId == commentController.UserId) // Kiểm tra xem người dùng hiện tại có phải là người tạo comment không
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                ],
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          SizedBox(
            height: CSizes.spaceBtwItems / 4,
          ),
          Text(
            DateFormat('dd/MM/yyyy').format(comment.createdAt),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: CSizes.spaceBtwItems / 2,
          ),
          ReadMoreText(
            comment.content,
            trimLines: 2,
            trimMode: TrimMode.Line,
            style: TextStyle(
                color: dark ? Colors.white : CColors.darkerGrey, fontSize: 14),
            trimExpandedText: 'show less',
            trimCollapsedText: 'show more',
            moreStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w800, color: CColors.primary),
            lessStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w800, color: CColors.primary),
          ),
          if (comment.attachmentUrls.isNotEmpty) ...[
            SizedBox(height: CSizes.spaceBtwItems / 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: attachmentNames.map((fileName) {
                final fileIndex = attachmentNames.indexOf(fileName);
                final fileUrl = comment.attachmentUrls[fileIndex];
                return GestureDetector(
                  onTap: () async {
                    final url = fileUrl.replaceAll(' ', '%2F');
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Could not launch $url')),
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.insert_drive_file,
                                color: dark ? Colors.white : Colors.grey),
                            const SizedBox(width: 8),
                            Text(_truncateFileName(fileName),
                                style: Theme.of(context).textTheme.labelMedium),
                          ]),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  },
  );
  }
}

String _truncateFileName(String fileName, {int maxLength = 30}) {
  return fileName.length <= maxLength
      ? fileName
      : fileName.substring(0, maxLength - 3) + '...';
}
