import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';
import 'package:workflow_management_app/features/personalization/controllers/update_phonenumber_controller.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';
import 'package:workflow_management_app/utils/validators/validation.dart';

class ChangePhonenumber extends StatelessWidget {
  const ChangePhonenumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhonenumberController());
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Change PhoneNumber',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              'You should use a phone number you use frequently so people can contact you more easily.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: CSizes.spaceBtwSections,
            ),

            /// Text field and Button
            Form(
                key: controller.updatePhoneNumberFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.phoneNumber,
                      validator: (value) =>
                          CValidator.validatePhoneNumber(value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: CTexts.phoneNo,
                          prefixIcon: Icon(Iconsax.call)),
                    ),
                    const SizedBox(
                      height: CSizes.spaceBtwInputFields,
                    ),
                  ],
                )),
            const SizedBox(
              height: CSizes.spaceBtwSections,
            ),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updatePhoneNumber(),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}