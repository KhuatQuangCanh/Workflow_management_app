import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/common/styles/shadows.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:workflow_management_app/common/widgets/texts/section_heading.dart';
import 'package:workflow_management_app/features/tasks/screens/home/screens/widgets/home_appbar.dart';
import 'package:workflow_management_app/features/tasks/screens/home/screens/widgets/show_personal_task_today.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/models/task.dart';
import 'package:workflow_management_app/services/notification_services.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    NotifyHelper().initializeNotification();

    // if (Platform.isIOS) {
    //   NotifyHelper().requestIOSPermissions();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Column(
        children: [
          // Header
          CPrimaryHeaderContainer(
            child: Column(
              children: [
                // AppBar
                CHomeAppBar(),
                SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
      
                // Search date
                CSearchContainer(),
                SizedBox(
                  height: CSizes.spaceBtwSections * 1.5,
                ),
              ],
            ),
          ),
      
          // --Body
          Padding(
            padding: EdgeInsets.only(
                left: CSizes.defaultSpace,
                right: CSizes.defaultSpace,
               ),
            child: Column(
              children: [
                CSectionHeading(
                  title: "Today' Task",
                 showActionButton: false,
                ),
                SizedBox(height: CSizes.spaceBtwItems/2,),

                Container(
                  padding: EdgeInsets.only(left: CSizes.sm),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: BoxDecoration(
                    boxShadow: [CShadowStyle.verticalProductShadow],
                    borderRadius: BorderRadius.circular(CSizes.productImageRadius),
                      color: dark ? CColors.darkerGrey : CColors.white
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat("dd/MM/yyyy").format(DateTime.now()),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: CHelperFunctions.isDarkMode(context)? Colors.white : Colors.grey),
                          ),
                          // -- Add Task
                          Container(
                            decoration: const BoxDecoration(
                                color: CColors.dark,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(CSizes.cardRadiusMd),
                                    bottomLeft: Radius.circular(CSizes.productImageRadius)
                                )
                            ),
                            child: const SizedBox(
                                width: CSizes.iconLg ,
                                height: CSizes.iconLg ,
                                child: Center(child: Icon(Iconsax.add, color: CColors.white,))),

                          )

                        ],
                      ),
                      SizedBox(height: CSizes.spaceBtwItems/2,),

                      ShowPersonalTaskToday()

                    ],
                  ),



                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
