import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../login/login.dart';


class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          children: [
            ///image
            Image(
              image: AssetImage(CImages.deliveredEmailTllustration),
              width: CHelperFunctions.screenWidth() * 0.6,
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),

            ///title & subtitle
            Text(
              CTexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),
            Text(
              CTexts.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),

            ///buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const LoginScreen()), child: const Text(CTexts.done)),
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {}, child: const Text(CTexts.resendEmail)),
            ),
          ],
        ),
      ),
    );
  }
}