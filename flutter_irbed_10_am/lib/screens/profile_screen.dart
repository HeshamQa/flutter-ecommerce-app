import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';
import 'package:flutter_irbed_10_am/general.dart';

import 'package:http/http.dart' as http;

import '../custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var width;
  var height;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  String? id;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    emailTextEditingController.text =
        await General.getPrefString(ConsValues.EMAIL, "");
    nameTextEditingController.text =
        await General.getPrefString(ConsValues.NAME, "");
    phoneTextEditingController.text =
        await General.getPrefString(ConsValues.PHONE, "");
    id = await General.getPrefString(ConsValues.ID, "");
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileScreen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              style: TextStyle(color: Colors.grey),
              enabled: false,
              controller: emailTextEditingController,
              decoration: InputDecoration(
                label: const Text("Email"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameTextEditingController,
              decoration: InputDecoration(
                label: const Text("Name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneTextEditingController,
              decoration: InputDecoration(
                label: const Text("Phone"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            CustomButton(
              onTap: () {
                updateProfile();
              },
              buttonText: "Update",
            ),
          ],
        ),
      ),
    );
  }

  updateProfile() async {
    EasyLoading.show(status: 'loading...');
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}updateProfile.php"),
      body: {
        "Id": id,
        "Name": nameTextEditingController.text,
        "Phone": phoneTextEditingController.text,
      },
    );
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      await General.savePrefString(
          ConsValues.NAME, nameTextEditingController.text);
      await General.savePrefString(
          ConsValues.PHONE, phoneTextEditingController.text);
      Navigator.pop(context);
    }
  }
}
