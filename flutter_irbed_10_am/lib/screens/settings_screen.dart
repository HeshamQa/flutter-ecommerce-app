import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/custom_button.dart';
import 'package:flutter_irbed_10_am/general.dart';
import 'package:flutter_irbed_10_am/screens/changepass_screen.dart';
import 'package:flutter_irbed_10_am/screens/profile_screen.dart';
import 'package:flutter_irbed_10_am/screens/splash_screen.dart';

import 'package:http/http.dart' as http;

import '../const_values.dart';
import '../general.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProfileScreen();
                    },
                  ),
                );
              },
              buttonText: "Profile"),
          CustomButton(
            buttonText: "Password",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ChangePassScreen();
                  },
                ),
              );
            },
          ),
          CustomButton(
            buttonText: "Logout",
            onTap: () async {
              await General.remove(ConsValues.NAME);
              await General.remove(ConsValues.EMAIL);
              await General.remove(ConsValues.PHONE);
              await General.remove(ConsValues.ID);
              await General.remove(ConsValues.USER_TYPE);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SplashScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
