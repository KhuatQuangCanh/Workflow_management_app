
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:workflow_management_app/utils/helpers/network_manager.dart';
import 'package:workflow_management_app/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // variable
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

// send resent Password email
  sendPasswordResetEmail() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;

      // Form validation
      if(!forgetPasswordFormKey.currentState!.validate()) return;

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // show success screen
      CLoaders.successSnackBar(title: 'Email Sent', message: 'Email link snet to reset your passsword.');

      // redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim(),));
    } catch (e) {
      CLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;


      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // show success screen
      CLoaders.successSnackBar(title: 'Email Sent', message: 'Email link snet to reset your passsword.');

    } catch (e) {
      CLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}