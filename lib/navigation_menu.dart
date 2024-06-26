import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/features/personalization/screens/profile/profile.dart';
import 'package:workflow_management_app/features/tasks/screens/group_work/screens/group_works.dart';
import 'package:workflow_management_app/features/tasks/screens/home/screens/home.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/screens/personal_tasks.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.updateSelectedIndex(index);
            });
          },
          backgroundColor: darkMode ? CColors.black : CColors.white,
          indicatorColor: darkMode ? CColors.white.withOpacity(0.1) : CColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.group), label: 'Group work'),
            NavigationDestination(icon: Icon(Iconsax.task), label: 'Personal tasks'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const GroupWorksScreen(),
    const PersonalTasksScreen(),
    const ProfileScreen()
  ];

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
