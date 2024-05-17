import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:workflow_management_app/features/authentication/screens/signup/signup.dart';
import 'package:workflow_management_app/navigation_menu.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';

class CLoginForm extends StatelessWidget {
  const CLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: CSizes.spaceBtwSections),
        child: Column(
          children: [
//email
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: CTexts.email),
            ),
            const SizedBox(
              height: CSizes.spaceBtwInputFields,
            ),

            ///Password
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: CTexts.password,
                  suffixIcon: Icon(Iconsax.eye_slash)),
            ),
            const SizedBox(
              height: CSizes.spaceBtwInputFields / 2,
            ),

            /// Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember ME
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(CTexts.rememberMe)
                  ],
                ),

                ///Forget Password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(CTexts.forgetPassword))
              ],
            ),
            const SizedBox(
              height: CSizes.spaceBtwInputFields,
            ),

            ///Sign in button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const NavigationMenu()),
                    child: const Text(CTexts.signIn))),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),

            ///create account button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text(CTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
