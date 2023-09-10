import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/custom_button.dart';
import 'package:flutter_irbed_10_am/providers/banner_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewBannerScreen extends StatefulWidget {
  const AddNewBannerScreen({Key? key}) : super(key: key);

  @override
  State<AddNewBannerScreen> createState() => _AddNewBannerScreenState();
}

class _AddNewBannerScreenState extends State<AddNewBannerScreen> {
  var width;
  var height;
  File? _image = null;
  bool showErrorUrl = false;
  TextEditingController _urlTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        width: width,
        height: height,
        child: Column(
          children: [
            InkWell(
              child: Center(
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: width,
                        height: height * 0.30,
                      )
                    : const Icon(Icons.image),
              ),
              onTap: () {
                showOptionChooser();
              },
            ),
            TextField(
              controller: _urlTextEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                label: Text("URL"),
                hintText: "https://www.google.com/",
                errorText: showErrorUrl ? "Insert Valid Url " : null,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        buttonText: "Save",
        onTap: () {
          showErrorUrl = _urlTextEditingController.text.isEmpty;
          if (_image == null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Wrong"),
                  content: Text("please select image"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else if (!showErrorUrl) {
            Provider.of<BannerProvider>(context, listen: false).addNewBanner(
              image: _image!,
              url: _urlTextEditingController.text,
            );
          }
          setState(() {});
        },
      ),
    );
  }

  void showOptionChooser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Please Choose"),
          actions: [
            TextButton(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                getImage(ImageSource.camera);
              },
            ),
            TextButton(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                getImage(ImageSource.gallery);
              },
            )
          ],
        );
      },
    );
  }

  getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();

    XFile? imageFile = await picker.pickImage(source: imageSource);
    if (imageFile == null) return;
    setState(
      () {
        _image = File(imageFile.path);
      },
    );
  }
}
