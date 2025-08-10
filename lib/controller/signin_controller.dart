// ignore_for_file: body_might_complete_normally_nullable, unused_field

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mapdemo/utils/app_constant.dart';

class SigninController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signinMethod(
      String email, String password, String userDeviceToken) async {
    try {
      EasyLoading.show(status: 'Please Wait');
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.primaryColor,
          colorText: AppConstant.textColor);
    }
  }
}
