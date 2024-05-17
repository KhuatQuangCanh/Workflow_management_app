
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workflow_management_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/device/device_utility.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

class onBoardingDotNavigation extends StatelessWidget {
  const onBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = CHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: CDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: CSizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.doNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: dark? CColors.light :CColors.dark, dotHeight: 6),
        ));
  }
}
