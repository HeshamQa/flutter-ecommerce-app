import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';
import 'package:flutter_irbed_10_am/general.dart';

import 'package:http/http.dart' as http;

import '../custom_button.dart';
import 'admin_banner_screen.dart';
import 'admin_categories_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminMainScreen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AdminCategoriesScreen();
                    },
                  ),
                );
              },
              buttonText: "Categories",
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onTap: () {},
              buttonText: "Shops",
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onTap: () {},
              buttonText: "Items",
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onTap: () {},
              buttonText: "Orders",
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AdminBannerScreen();
                    },
                  ),
                );
              },
              buttonText: "Banner",
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onTap: () {},
              buttonText: "Update Password",
            ),
          ],
        ),
      ),
    );
  }
}
