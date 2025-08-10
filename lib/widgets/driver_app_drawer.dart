import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapdemo/screen/auth/signin_screen.dart';
import 'package:mapdemo/screen/driver_screen.dart';
import 'package:mapdemo/utils/app_constant.dart';

class DriverAppDrawer extends StatefulWidget {
  @override
  State<DriverAppDrawer> createState() => _DriverAppDrawerState();
}

class _DriverAppDrawerState extends State<DriverAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35),
      child: Drawer(
        backgroundColor: AppConstant.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Quest Bus Tracker',
                  style: TextStyle(
                      color: AppConstant.textColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Version 1.1.0',
                  style: TextStyle(color: AppConstant.textColor),
                ),
              ),
            ),
            Divider(
              color: AppConstant.textColor,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  onTap: () {
                    Get.offAll(() => DriverScreen());
                  },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    'Home',
                    style: TextStyle(
                        color: AppConstant.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: AppConstant.textColor,
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: GestureDetector(
                onTap: () {},
                child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'Settings',
                      style: TextStyle(
                          color: AppConstant.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.production_quantity_limits,
                      color: AppConstant.textColor,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  onTap: () {
                    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                    firebaseAuth.signOut();

                    Get.offAll(() => SigninScreen());
                  },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: AppConstant.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: AppConstant.textColor,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
