


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/data/repositories/user/user_repository.dart';
import 'package:workflow_management_app/features/personalization/models/user_model.dart';
import 'package:workflow_management_app/utils/helpers/network_manager.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  // -- SIGNUP
  void signup() async{
    try{
      // Start Loading
      // TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.onBoardingImage1);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;


      // Form validation
      if(!signupFormKey.currentState!.validate()) return;


      // --privacy policy check
      if(!privacyPolicy.value) {
        CLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use'
        );
        return;
      }

      // -- Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWidthEmailAndPassword(email.text.trim(), password.text.trim());

      // -- Save Authenticated user in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          // username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: ''
      );

      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);

      // remove loader
      // TFullScreenLoader.stopLoading();


      // -- show success message

      CLoaders.successSnackBar(title: "congratulations", message: 'Your account has been create! Verify amil to continue');

      // --Move to Verify Email Screen
      Get.to(() =>  VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      // Show some Generic Error to the user
      CLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      // } finally {
      // remove loader
      // TFullScreenLoader.stopLoading();
    }
  }
}