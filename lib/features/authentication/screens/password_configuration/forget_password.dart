import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Padding(padding: EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///heading

            Text(
              CTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),
            Text(
              CTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems*2,
            ),
            ///text field
            TextFormField(
              decoration: InputDecoration(
                  labelText: CTexts.email, prefixIcon: Icon(Iconsax.direct_right)
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwSections,),


            ///submit button
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: () => Get.off(() => ResetPassword()), child: Text(CTexts.submit)),)
          ],
        ),),

    );
  }
}