import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

class CFormDivider extends StatelessWidget {
  const CFormDivider({
    super.key, required this.dividerText,
  });
  final String dividerText;


  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
              color: dark ? CColors.darkGrey : Colors.grey,
              thickness: 0.5,
              indent: 60,
              endIndent: 5,
            )),
        Text(CTexts.orSignInWith.capitalize!, style: Theme.of(context).textTheme.labelMedium,),
        Flexible(
            child: Divider(
              color: dark ? CColors.darkGrey : Colors.grey,
              thickness: 0.5,
              indent: 5,
              endIndent: 60,
            )),
      ],
    );
  }
}