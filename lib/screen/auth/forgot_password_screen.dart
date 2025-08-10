import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mapdemo/controller/forgot_password_controller.dart';
import 'package:mapdemo/screen/auth/signin_screen.dart';
import 'package:mapdemo/utils/app_constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController useremailController = TextEditingController();
  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.textColor,
      appBar: AppBar(
        leading: BackButton(
          color: AppConstant.primaryColor,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Quest Bus Tracking',
          style: TextStyle(
            color: AppConstant.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 90),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/uni.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'Forgot your Password',
                style: TextStyle(
                  color: AppConstant.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: useremailController,
                  decoration: InputDecoration(
                      hintText: 'Email', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  String email = useremailController.text.trim();
                  if (email.isEmpty) {
                    Get.snackbar('Error', 'Please Enter All Details',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.primaryColor,
                        colorText: AppConstant.textColor);
                  } else {
                    forgotPasswordController.forgotpasswordMethod(email);
                    Get.offAll(() => SigninScreen());
                  }
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: AppConstant.textColor,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
