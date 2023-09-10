import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/providers/categories_provider.dart';
import 'package:flutter_irbed_10_am/screens/add_new_category_screen.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import '../custom_button.dart';

class AdminCategoriesScreen extends StatefulWidget {
  const AdminCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AdminCategoriesScreen> createState() => _AdminCategoriesScreenState();
}

class _AdminCategoriesScreenState extends State<AdminCategoriesScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false)
        .getAdminCategories();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: width,
        height: height,
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
                      return AddNewCategoryScreen();
                    },
                  ),
                );
              },
              buttonText: "Add new category",
            ),
            Container(
              width: width,
              height: height * .7,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Consumer<CategoriesProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.listCategoriesModelAdmin.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              value.listCategoriesModelAdmin[index].Name,
                            ),
                            Text(
                              value.listCategoriesModelAdmin[index].Id_statetype,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
