// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:mapdemo/utils/app_constant.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> forgotpasswordMethod(String useremail) async {
    try {
      EasyLoading.show(status: 'Please Wait');
      await _firebaseAuth.sendPasswordResetEmail(email: useremail);

      Get.snackbar('success!', 'Email Successfully sent to $useremail',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.primaryColor,
          colorText: AppConstant.textColor);

      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.primaryColor,
          colorText: AppConstant.textColor);
    }
  }
}
