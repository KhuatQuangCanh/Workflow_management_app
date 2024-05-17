

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:workflow_management_app/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:workflow_management_app/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:workflow_management_app/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:workflow_management_app/features/authentication/screens/onboarding/widgets/onboarding_ship.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          // trang cuộn
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: CImages.onBoardingImage1,
                title: CTexts.onBroadingTitle1,
                subTitle: CTexts.onBroadingSubTitle1,
              ),
              OnBoardingPage(
                image: CImages.onBoardingImage2,
                title: CTexts.onBroadingTitle2,
                subTitle: CTexts.onBroadingSubTitle2,
              ),
              OnBoardingPage(
                image: CImages.onBoardingImage3,
                title: CTexts.onBroadingTitle3,
                subTitle: CTexts.onBroadingSubTitle3,
              ),
            ],
          ),
          // skip button
          const OnBoardingSkip(),
          // điều hướng dấu chấm
          const onBoardingDotNavigation(),
          // nút next
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
