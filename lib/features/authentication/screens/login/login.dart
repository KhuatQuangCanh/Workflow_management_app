import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/common/styles/spacing_styles.dart';
import 'package:workflow_management_app/common/widgets/login_signup/form_divider.dart';
import 'package:workflow_management_app/common/widgets/login_signup/social_button.dart';
import 'package:workflow_management_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:workflow_management_app/features/authentication/screens/login/widgets/login_header.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: CSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //logo, title, subtitle
              const CLoginHeader(),

              // form
              const CLoginForm(),

              // Divider
              CFormDivider(dividerText: CTexts.orSignInWith.capitalize!),
const SizedBox(height: CSizes.spaceBtwItems,),

              // Footer
              const CSocialButtons()

            ],
          ),
        ),


      ),
    );
  }
}
