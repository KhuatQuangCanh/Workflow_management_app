import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';

class CTerm_conditions_checkbox extends StatelessWidget {
  const CTerm_conditions_checkbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    // final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(()=> Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value )),
        ),
        const SizedBox(
          width: CSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${CTexts.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${CTexts.privacyPolicy} ',
              style:
              Theme.of(context).textTheme.bodyMedium!.apply(
                color: CColors.primary,
                // color: dark? Colors.white: TColors.primary,
                // decoration: TextDecoration.underline,
                // decorationColor: dark? Colors.white: TColors.primary,
              )),
          TextSpan(
              text: '${CTexts.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: CTexts.termsOfUse,
              style:
              Theme.of(context).textTheme.bodyMedium!.apply(
                color: CColors.primary,
              )),
        ]))
      ],
    );
  }
}