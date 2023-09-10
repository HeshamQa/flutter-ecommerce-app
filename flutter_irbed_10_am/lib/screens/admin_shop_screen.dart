import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/models/categories_model.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import '../custom_button.dart';
import '../providers/categories_provider.dart';
import '../providers/shop_provider.dart';
import 'add_new_banner_imagePiker_Screen.dart';

class AdminShopScreen extends StatefulWidget {
  const AdminShopScreen({Key? key}) : super(key: key);

  @override
  State<AdminShopScreen> createState() => _AdminShopScreenState();
}

class _AdminShopScreenState extends State<AdminShopScreen> {
  var width;
  var height;

  CategoriesModel? selectedCategoriesModel;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false)
        .getAdminCategories()
        .then(
      (value) {
        selectedCategoriesModel =
            Provider.of<CategoriesProvider>(context, listen: false)
                .listCategoriesModelAdmin[0];
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Consumer<CategoriesProvider>(
                builder: (context, value, child) {
                  return DropdownButton<CategoriesModel>(
                    // Step 3.
                    value: selectedCategoriesModel,
                    // Step 4.
                    items: value.listCategoriesModelAdmin
                        .map<DropdownMenuItem<CategoriesModel>>(
                            (CategoriesModel value) {
                      return DropdownMenuItem<CategoriesModel>(
                        value: value,
                        child: Text(
                          value.Name,
                          style: const TextStyle(fontSize: 30),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (CategoriesModel? newValue) {
                      setState(() async {
                        selectedCategoriesModel = newValue!;
                    await    Provider.of<ShopProvider>(context, listen: false).getShops(selectedCategoriesModel!.Id);

                      });
                    },
                  );

                },
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
                        return const AddNewBannerScreen();
                      },
                    ),
                  );
                },
                buttonText: "Add Shop",
              ),
            ],
          ),
          Container(
            width: width,
            height: height - 60,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Consumer<ShopProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.listShopModel.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Image.network(
                              value.listShopModel[index].imageUrl,
                              width: width - 32,
                              height: 150,
                            ),
                            Text(
                              value.listShopModel[index].Id_categories,
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
