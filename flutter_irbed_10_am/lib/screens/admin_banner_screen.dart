import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/providers/categories_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import '../custom_button.dart';
import '../providers/banner_provider.dart';
import 'add_new_banner_imagePiker_Screen.dart';

class AdminBannerScreen extends StatefulWidget {
  const AdminBannerScreen({Key? key}) : super(key: key);

  @override
  State<AdminBannerScreen> createState() => _AdminBannerScreenState();
}

class _AdminBannerScreenState extends State<AdminBannerScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<BannerProvider>(context, listen: false).getBannerImages();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: height * .12,
            child: Column(
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
                          return AddNewBannerScreen();
                        },
                      ),
                    );
                  },
                  buttonText: "Add Image to Banner",
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: height * .7,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Consumer<BannerProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.listImageBanner.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Image.network(
                              value.listImageBanner[index].ImageUrl,
                              width: width - 32,
                              height: 150,
                            ),
                            Text(
                              value.listImageBanner[index].URL,
                            ),
                            CustomButton(
                              buttonText: "Edit",
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
