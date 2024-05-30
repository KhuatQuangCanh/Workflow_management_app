import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/data/repositories/user/user_repository.dart';
import 'package:workflow_management_app/features/personalization/controllers/user_controller.dart';
import 'package:workflow_management_app/features/personalization/screens/profile/profile.dart';
import 'package:workflow_management_app/navigation_menu.dart';
import 'package:workflow_management_app/utils/helpers/network_manager.dart';
import 'package:workflow_management_app/utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // -- Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;

      // Form Validation
      if(!updateUserNameFormKey.currentState!.validate()) return;

      // Update user firstname and lastname in the Firebase Firestore.
      Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // show success message
      CLoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated.');

      // Move to previous screeen 
      Get.off(() => const NavigationMenu());

    } catch (e) {
      CLoaders.errorSnackBar(title: 'Oh Snap!', message:  e.toString());
    }
  }
}
