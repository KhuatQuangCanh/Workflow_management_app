import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/features/personalization/controllers/user_controller.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_string.dart';

class CHomeAppBar extends StatelessWidget {
  const CHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = Get.find<AuthenticationRepository>();
    final controller = Get.put(UserController());
    return CAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: CColors.grey),
          ),
          Obx( ()
            => Text(
              controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: CColors.white),
            ),
          )
        ],
      ),
      actions: [
        IconButton(onPressed: () async {
          // Xử lý đăng xuất tại đây, ví dụ: xoá token người dùng, v.v.
          await authRepo.logout();
        }, icon: Image(image: AssetImage(CImages.logoutIcon)))
      ]
    );
  }
}
