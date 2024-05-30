import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/features/authentication/screens/signup/verify_email.dart';
import 'package:workflow_management_app/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';

import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';

class CSignupForm extends StatelessWidget {
  const CSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator:(value) => CValidator.validateEmtyText('FirstName', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: CSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => CValidator.validateEmtyText('LastName', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),


          /// Username
          // TextFormField(
          //   controller: controller.username,
          //   validator: (value) => CValidator.validateEmtyText('Username', value),
          //   expands: false,
          //   decoration: const InputDecoration(
          //     labelText: CTexts.username,
          //     prefixIcon: Icon(Iconsax.user_edit),
          //   ),
          // ),
          const SizedBox(
            height: CSizes.spaceBtwInputFields,
          ),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => CValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: CTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: CSizes.spaceBtwInputFields,
          ),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => CValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: CTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: CSizes.spaceBtwInputFields,
          ),

          /// Password
          Obx(
                () => TextFormField(
              controller: controller.password,
              validator: (value) => CValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: CTexts.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value? Iconsax.eye_slash : Iconsax.eye))
              ),
            ),
          ),
          const SizedBox(
            height: CSizes.spaceBtwInputFields,
          ),

          const CTerm_conditions_checkbox(),
          const SizedBox(
            height: CSizes.spaceBtwSections,
          ),

          /// Sign Up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(CTexts.createAccount)),
          )
        ],
      ),
    );
  }
}