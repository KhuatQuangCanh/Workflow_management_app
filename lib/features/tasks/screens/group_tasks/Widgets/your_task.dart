import 'package:flutter/material.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class CYourTasksHorizontal extends StatelessWidget {
  const CYourTasksHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CSizes.productImageRadius),
        color: dark ? CColors.darkerGrey : CColors.softGrey,
      ),

      child:  Padding(
          padding: EdgeInsets.all(CSizes.md),
        child: Image(image: AssetImage(CImages.onBoardingImage1)),
      ),


    );
  }
}
