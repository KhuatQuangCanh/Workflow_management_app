
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/device/device_utility.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Positioned(
        right: CSizes.defaultSpace,
        bottom: CDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: dark ? CColors.primary : Colors.grey,
              side: BorderSide.none,
            ),
            onPressed: () => OnBoardingController.instance.nextPage(),
            child: const Icon(Iconsax.arrow_right_3)));
  }
}
