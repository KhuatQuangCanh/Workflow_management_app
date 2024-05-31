import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/common/styles/shadows.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:workflow_management_app/common/widgets/texts/section_heading.dart';
import 'package:workflow_management_app/features/tasks/screens/group_tasks/Widgets/your_task.dart';
import 'package:workflow_management_app/features/tasks/screens/home/screens/widgets/home_appbar.dart';
import 'package:workflow_management_app/features/tasks/screens/home/screens/widgets/show_personal_task_today.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/models/personal_task.dart';
import 'package:workflow_management_app/services/notification_services.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

import '../../../../../utils/helpers/helper_functions.dart';
import '../../personal_tasks/controllers/personal_tasks_controller.dart';
import '../../personal_tasks/screens/widgets/add_task_page.dart';

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
    final controller = Get.put(PersonalTasksController());

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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: CSizes.defaultSpace,
                  right: CSizes.defaultSpace,
                ),
                child: Column(
                  children: [
                    CSectionHeading(
                      title: "Today' Tasks",
                      showActionButton: false,
                    ),
                    SizedBox(
                      height: CSizes.spaceBtwItems / 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: CSizes.sm),
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      decoration: BoxDecoration(
                          boxShadow: [CShadowStyle.verticalProductShadow],
                          borderRadius:
                              BorderRadius.circular(CSizes.productImageRadius),
                          color: dark? CColors.dark: Colors.white),
              
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: CSizes.sm, top: CSizes.sm),
                                child: Text( "day: "+
                                  DateFormat("dd/MM").format(DateTime.now()),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: CColors.darkGrey,
                                  ),
                                ),
                              ),
                              // -- Add Task
                              GestureDetector(
                                onTap: () async {
                                  await Get.to(const AddTaskScreen());
                                  controller.getTasks();
                                  controller.titleController.clear();
                                  controller.noteController.clear();
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: CColors.primary,
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                              Radius.circular(CSizes.cardRadiusMd),
                                          bottomLeft: Radius.circular(
                                              CSizes.productImageRadius))),
                                  child: const SizedBox(
                                      width: CSizes.iconLg,
                                      height: CSizes.iconLg,
                                      child: Center(
                                          child: Icon(
                                        Iconsax.add,
                                        color: CColors.white,
                                      ))),
                                ),
                              )
                            ],
                          ),

                          const Divider(),
                          ShowPersonalTaskToday()
                        ],
                      ),
                    ),
              
                    SizedBox(height: CSizes.spaceBtwSections,),
                    CSectionHeading(title: "Group work",showActionButton: false,),
                    SizedBox(height: CSizes.spaceBtwSections/2,),
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                        const SizedBox(
                          width: CSizes.spaceBtwItems,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) =>
                        const CYourTasksHorizontal(),
                      ),
                    ),
              
              
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
