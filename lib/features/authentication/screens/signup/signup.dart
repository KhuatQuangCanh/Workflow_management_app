import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/common/widgets/login_signup/form_divider.dart';
import 'package:workflow_management_app/common/widgets/login_signup/social_button.dart';
import 'package:workflow_management_app/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              CTexts.signupTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: CSizes.spaceBtwSections,
            ),
            //form
            const CSignupForm(),
            const SizedBox(height: CSizes.spaceBtwSections,),

            //Divider
            CFormDivider(dividerText: CTexts.orSignUpWith.capitalize!),

            const SizedBox(height: CSizes.spaceBtwSections,),

            /// Social Button
            const CSocialButtons(),
          ],

        ),),
      ),
    );
  }
}
