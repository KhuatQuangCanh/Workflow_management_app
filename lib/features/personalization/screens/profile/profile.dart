import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';
import 'package:workflow_management_app/features/personalization/controllers/user_controller.dart';
import 'package:workflow_management_app/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:workflow_management_app/features/personalization/screens/profile/widgets/profile_menu.dart';

import '../../../../common/widgets/images/circular_images.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const CAppBar(title: Center(child: Text("Profile")),
      ),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.only(left: CSizes.defaultSpace, right: CSizes.defaultSpace, bottom: CSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                     Obx(() {
                       final networkImage = controller.user.value.profilePicture;
                       final image = networkImage.isNotEmpty? networkImage: CImages.user;
                       return CCircularImage(image: image, width: 80, height: 80,isNetworkImage: networkImage.isNotEmpty,);
                     } ),

                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              ///Details

              const SizedBox(height: CSizes.spaceBtwItems/2,),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems/1.5,),
              const CSectionHeading(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: CSizes.spaceBtwItems,),

              // CProfileMenu(title: 'Name', value: 'Khuat Quang Canh', onpressed: () {},),
              CProfileMenu(title: 'Username', value: controller.user.value.fullName, onpressed: () => Get.to(() => const ChangeName()),),
              CProfileMenu(title: 'Gender', value: 'Male', onpressed: () {},),

              const SizedBox(height: CSizes.spaceBtwItems/1.5,),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems/1.5,),

              ///heading personal info
              const CSectionHeading(title: 'Personal Information', showActionButton: false,),
              const SizedBox(height: CSizes.spaceBtwItems,),

              CProfileMenu(title: 'User ID', value: controller.user.value.id,icon: Iconsax.copy , onpressed: () {},),
              CProfileMenu(title: 'E-mail', value: controller.user.value.email, onpressed: () {},),
              CProfileMenu(title: 'Phone Number', value:controller.user.value.phoneNumber, onpressed: () {},),
              CProfileMenu(title: 'Date of Birth', value: '07/06/2002', onpressed: () {},),

              const SizedBox(height: CSizes.spaceBtwItems/1.5,),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems/2,),


              Center(
                child: TextButton(onPressed: () => controller.deleteAccountWaringPopup(),
                    child: const Text('Delete Account', style: TextStyle(color: Colors.red),)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
