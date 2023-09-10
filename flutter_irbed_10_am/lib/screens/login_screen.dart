import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';
import 'package:flutter_irbed_10_am/general.dart';
import 'package:flutter_irbed_10_am/screens/admin_main_screen.dart';
import 'package:http/http.dart' as http;

import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var w;
  var h;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.jpg",
              width: w,
              height: h * .2,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: h * .05,
            ),
            TextField(
              controller: emailTextEditingController,
              decoration: InputDecoration(
                label: const Text("Email"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: h * .05,
            ),
            TextField(
              controller: passwordTextEditingController,
              decoration: InputDecoration(
                label: const Text("Password"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  login();
                },
                child: const Text("Login")),
            TextButton(onPressed: () {}, child: const Text("SignUp")),
          ],
        ),
      ),
    );
  }

//add if statment user type 1 = user or if 2 = admin
  login() async {
    EasyLoading.show(status: 'loading...');

    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}login.php"),
      body: {
        "Email": emailTextEditingController.text,
        "Password": passwordTextEditingController.text
      },
    );
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      print("jsonBody = $jsonBody");

      if (jsonBody["result"]) {
        General.savePrefString(ConsValues.ID, jsonBody['Id']);
        General.savePrefString(ConsValues.NAME, jsonBody['Name']);
        General.savePrefString(ConsValues.EMAIL, jsonBody['Email']);
        General.savePrefString(ConsValues.PHONE, jsonBody['Phone']);
        General.savePrefString(ConsValues.USER_TYPE, jsonBody['UserType']);
        if (jsonBody['UserType'] == "1") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const MainScreen()));
        } else if (jsonBody['UserType'] == "2") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const AdminMainScreen()));
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(jsonBody["UserType Error"]),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(jsonBody["msg"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            );
          },
        );
      }
    }
  }
}
