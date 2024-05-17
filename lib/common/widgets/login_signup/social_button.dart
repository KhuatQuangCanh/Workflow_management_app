import 'package:flutter/material.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

class CSocialButtons extends StatelessWidget {
  const CSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: CColors.grey),borderRadius: BorderRadius.circular(100)),
          child: IconButton(onPressed: () {},
              icon: const Image(
                  width: CSizes.iconMd,
                  height: CSizes.iconMd,
                  image: AssetImage(CImages.google))),
        ),
        const SizedBox(width: CSizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(border: Border.all(color: CColors.grey),borderRadius: BorderRadius.circular(100)),
          child: IconButton(onPressed: () {},
              icon: const Image(
                  width: CSizes.iconMd,
                  height: CSizes.iconMd,
                  image: AssetImage(CImages.facebook))),
        ),

      ],
    );
  }
}