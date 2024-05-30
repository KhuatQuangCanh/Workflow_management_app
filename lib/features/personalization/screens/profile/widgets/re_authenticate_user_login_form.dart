import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/features/personalization/controllers/user_controller.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';
import 'package:workflow_management_app/utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: Text('Re-Authenticate User'),),
      body:  SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- Email
                  TextFormField(
                    controller:  controller.verifyEmail,
                    validator: CValidator.validateEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: CTexts.email
                    ),
                  ),
                  SizedBox(height: CSizes.spaceBtwInputFields,),

                  // -- Password
                  Obx(
                        () => TextFormField(
                      controller: controller.verifyPassword,
                      validator: (value) => CValidator.validateEmtyText('Password',value),
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                          labelText: CTexts.password,
                          prefixIcon: Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye))),
                    ),
                  ),
                  SizedBox(height: CSizes.spaceBtwSections,),

                  /// LOGIN button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: Text('Verify')),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
