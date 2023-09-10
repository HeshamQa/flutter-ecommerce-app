import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/custom_button.dart';
import 'package:flutter_irbed_10_am/providers/banner_provider.dart';
import 'package:flutter_irbed_10_am/providers/categories_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  var width;
  var height;

  String dropdownValue = "Enable";
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
            TextField(
              controller: _urlTextEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                label: const Text("Category Name"),
                errorText: showErrorUrl ? "Insert Valid Name " : null,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>['Enable', 'Disable']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 30),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },

            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        buttonText: "Save",
        onTap: () {
          showErrorUrl = _urlTextEditingController.text.isEmpty;
          if (!showErrorUrl) {
            Provider.of<CategoriesProvider>(context, listen: false)
                .AdminAddNewCategories(Id_statustypes: dropdownValue=="Enable"? 1 : 0, Name: _urlTextEditingController.text);
          }
          setState(() {});
        },
      ),
    );
  }
}
