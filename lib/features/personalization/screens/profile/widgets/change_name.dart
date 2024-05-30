import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';
import 'package:workflow_management_app/features/personalization/controllers/update_name_controller.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/constants/text_string.dart';
import 'package:workflow_management_app/utils/validators/validation.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
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
              'Use real name for easy verification. this name will apper on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: CSizes.spaceBtwSections,
            ),

            /// Text field and Button
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          CValidator.validateEmtyText('First Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: CTexts.firstName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(
                      height: CSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          CValidator.validateEmtyText('Last Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: CTexts.lastName,
                          prefixIcon: Icon(Iconsax.user)),
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
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
