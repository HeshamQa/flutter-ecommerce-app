import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';
import 'package:flutter_irbed_10_am/general.dart';

import 'package:http/http.dart' as http;

import '../custom_button.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  var width;
  var height;
  TextEditingController passTextEditingController = TextEditingController();
  TextEditingController confirmTextEditingController = TextEditingController();

  String? id;

  bool showErrorConfirm = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    id = await General.getPrefString(ConsValues.ID, "");
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPassScreen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: passTextEditingController,
              decoration: InputDecoration(
                label: const Text("New Password"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: confirmTextEditingController,
              decoration: InputDecoration(
                label: const Text("Confirm"),
                errorText: showErrorConfirm ? "Not matched" : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            CustomButton(
              onTap: () {
                showErrorConfirm = passTextEditingController.text !=
                    confirmTextEditingController.text;
                if (!showErrorConfirm) {
                  updatePassword();
                }
                setState(() {});
              },
              buttonText: "Update Password",
            ),
          ],
        ),
      ),
    );
  }

  updatePassword() async {
    EasyLoading.show(status: 'loading...');
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}updatePassword.php"),
      body: {
        "Id": id,
        "Password": passTextEditingController.text,
      },
    );
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      Navigator.pop(context);
    }
  }
}
