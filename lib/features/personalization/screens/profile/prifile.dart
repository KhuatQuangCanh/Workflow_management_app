import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';
import 'package:workflow_management_app/features/personalization/screens/profile/widgets/profile_menu.dart';

import '../../../../common/widgets/images/circular_images.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: Center(child: Text("Profile")),
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
                    const CCircularImage(image: CImages.user, width: 80, height: 80,),

                    TextButton(onPressed: () {}, child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              ///Details

              const SizedBox(height: CSizes.spaceBtwItems/2,),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems/1.5,),
              const CSectionHeading(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: CSizes.spaceBtwItems,),

              CProfileMenu(title: 'Name', value: 'Khuat Quang Canh', onpressed: () {},),
              CProfileMenu(title: 'Username', value: 'Khuat Quang Canh', onpressed: () {},),

              const SizedBox(height: CSizes.spaceBtwItems/1.5,),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems/1.5,),

              ///heading personal info
              const CSectionHeading(title: 'Personal Information', showActionButton: false,),
              const SizedBox(height: CSizes.spaceBtwItems,),

              CProfileMenu(title: 'User ID', value: '852000',icon: Iconsax.copy , onpressed: () {},),
              CProfileMenu(title: 'E-mail', value: 'kqc07062002@gmail.com', onpressed: () {},),
              CProfileMenu(title: 'Phone Number', value: '0353076020', onpressed: () {},),
              CProfileMenu(title: 'Gender', value: 'Male', onpressed: () {},),
              CProfileMenu(title: 'Date of Birth', value: '07/06/2002', onpressed: () {},),

              const SizedBox(height: CSizes.spaceBtwItems/1.5,),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems/2,),


              Center(
                child: TextButton(onPressed: () {}, child: const Text('Close Account', style: TextStyle(color: Colors.red),)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
