import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/data/repositories/user/user_repository.dart';
import 'package:workflow_management_app/features/personalization/controllers/user_controller.dart';
import 'package:workflow_management_app/navigation_menu.dart';
import 'package:workflow_management_app/utils/helpers/network_manager.dart';
import 'package:workflow_management_app/utils/popups/loaders.dart';

class UpdatePhonenumberController extends GetxController {
  static UpdatePhonenumberController get instance => Get.find();

  final phoneNumber = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // -- Fetch user record
  Future<void> initializeNames() async {
    phoneNumber.text = userController.user.value.phoneNumber;
  }

  Future<void> updatePhoneNumber() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;

      // Update user firstname and lastname in the Firebase Firestore.
      Map<String, dynamic> name = {'PhoneNumber': phoneNumber.text.trim()};
      await userRepository.updateSingleField(name);

      // update the Rx user value
      userController.user.value.phoneNumber = phoneNumber.text.trim();

      // show success message
      CLoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated.');

      // Move to previous screeen
      Get.off(() => const NavigationMenu());

    } catch (e) {
      CLoaders.errorSnackBar(title: 'Oh Snap!', message:  e.toString());
    }
  }
}
