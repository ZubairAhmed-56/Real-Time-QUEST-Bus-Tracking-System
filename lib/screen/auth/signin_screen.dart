// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapdemo/controller/get_user_data_controller.dart';
import 'package:mapdemo/controller/signin_controller.dart';
import 'package:mapdemo/screen/auth/forgot_password_screen.dart';
import 'package:mapdemo/screen/auth/signup_screen.dart';
import 'package:mapdemo/screen/driver_screen.dart';
import 'package:mapdemo/screen/user_screen.dart';
import 'package:mapdemo/utils/app_constant.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GetUserDataController _getUserDataController =
      Get.put(GetUserDataController());
  SigninController signinController = Get.put(SigninController());
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.textColor,
      appBar: AppBar(
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
                'Please signin before track your bus',
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
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: userpasswordController,
                  decoration: InputDecoration(
                      hintText: 'Password', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 200),
                child: GestureDetector(
                  onTap: () => Get.to(() => ForgotPasswordScreen()),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: AppConstant.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  String email = useremailController.text.trim();
                  String password = userpasswordController.text.trim();
                  String userDeviceToken = '';

                  if (email.isEmpty || password.isEmpty) {
                    Get.snackbar('Error', 'Please Enter All Details',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.primaryColor,
                        colorText: AppConstant.textColor);
                  } else {
                    UserCredential? userCredential = await signinController
                        .signinMethod(email, password, userDeviceToken);
                    var Userdata = await _getUserDataController
                        .getuserdataMethod(userCredential!.user!.uid);
                    if (userCredential != null) {
                      if (userCredential.user!.emailVerified) {
                        if (Userdata[0]['isDriver'] == true) {
                          Get.offAll(() => DriverScreen());
                        } else {
                          Get.offAll(() => UserScreen());
                        }
                      } else {
                        Get.snackbar(
                            'Error', 'Please Verify your email before login!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.primaryColor,
                            colorText: AppConstant.textColor);
                      }
                    }
                  }
                },
                child: Text(
                  'SignIn',
                  style: TextStyle(
                      color: AppConstant.textColor,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.primaryColor),
              ),
              Padding(
                padding: EdgeInsets.only(left: 80),
                child: Row(
                  children: [
                    Text('Don\'t have an accout?'),
                    GestureDetector(
                      onTap: () => Get.to(() => SignUpScreen()),
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                            color: AppConstant.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
