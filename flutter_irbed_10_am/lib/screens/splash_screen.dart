import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/general.dart';
import 'package:flutter_irbed_10_am/screens/admin_main_screen.dart';
import 'package:flutter_irbed_10_am/screens/login_screen.dart';
import 'package:flutter_irbed_10_am/screens/main_screen.dart';

import '../const_values.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }

  checkUserLogin() {
    General.getPrefString(ConsValues.ID, "").then(
      (value) {
        if (value == "") {
          Timer(
              Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen())));
        } else {
          General.getPrefString(ConsValues.USER_TYPE, "").then(
            (value) {
              if (value == "1") {
                Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MainScreen(),
                    ),
                  ),
                );
              } else {
                Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AdminMainScreen(),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.jpg"),
      ),
    );
  }
}
