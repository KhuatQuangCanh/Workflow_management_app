import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/data/repositories/user/user_repository.dart';
import 'package:workflow_management_app/features/authentication/screens/login/login.dart';
import 'package:workflow_management_app/features/personalization/models/user_model.dart';
import 'package:workflow_management_app/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/network_manager.dart';
import 'package:workflow_management_app/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      // profileLoading.value = true;
      final user = await userRepository.fetchUserDetail();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
    // finally {
    //   profileLoading.value = false;
    // }
  }

  // Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // first update Rx user and then check if user data already stored. if not store new data
      await fetchUserRecord();

      if(user.value.id.isEmpty){
        if (userCredentials != null) {
          //  Convert Name to First and Last name
          final nameParts =
          UserModel.nameParts(userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : ' ',
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );
          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }


    } catch (e) {
      CLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong white saving your information. yo can re-save your data in your Profile.');
    }
  }

  /// Delete Account Waring
  void deleteAccountWaringPopup() {
    Get.defaultDialog(
        contentPadding: EdgeInsets.all(CSizes.md),
        title: 'Delete Account',
        titleStyle: TextStyle(color: Colors.red),
        middleText:
            'Are you sure you want too delete your account permanently? this action is not reversible and all of your data will be removed permanently.',
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: CSizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: Text('Cancel')));
  }

  // - Delete User Account
  void deleteUserAccount() async {
    try {
      // First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          Get.offAll(() => LoginScreen());
        } else if (provider == 'password') {
          Get.to(() => ReAuthLoginForm());
        }
      }
    } catch (e) {
      CLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // -- Re -authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;

      // Form Validation
      if(!reAuthFormkey.currentState!.validate()) return;

      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      Get.offAll(() => LoginScreen());


    } catch (e) {
      CLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }


  // upload profile image
  uploadUserProfilePicture() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512, );
      if(image !=null){
        imageUploading.value = true;

        final imageUrl = await userRepository.uploadImage('Users/Image/Profile/', image);

        // update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        CLoaders.successSnackBar(title: 'Congratulation', message: 'Your Profile Image has been updated!');
      }

    }catch(e) {
      CLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      imageUploading.value = false;

    }

  }

}
