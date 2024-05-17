import 'package:flutter/material.dart';
import 'package:workflow_management_app/common/styles/spacing_styles.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
        required this.image,
        required this.title,
        required this.subTitle,
        this.onPressed});

  final String image, title, subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              ///image
              Image(
                image: AssetImage(image),
                width: CHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),

              ///title & subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              Text(
                subTitle,
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
                    onPressed: onPressed, child: const Text(CTexts.cContinue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}