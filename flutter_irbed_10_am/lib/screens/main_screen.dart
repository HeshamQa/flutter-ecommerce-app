import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/providers/banner_provider.dart';
import 'package:flutter_irbed_10_am/providers/categories_provider.dart';
import 'package:flutter_irbed_10_am/providers/shop_provider.dart';
import 'package:flutter_irbed_10_am/screens/items_screen.dart';
import 'package:flutter_irbed_10_am/screens/orederHistory_screen.dart';
import 'package:flutter_irbed_10_am/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<BannerProvider>(context, listen: false).getBannerImages();
    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.reorder,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OrderHistoryScreen();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: height * .3,
            margin: const EdgeInsets.all(8),
            child: Consumer<BannerProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await launchUrl(
                            Uri.parse(value.listImageBanner[index].URL));
                      },
                      child: Image.network(
                        value.listImageBanner[index].ImageUrl,
                        fit: BoxFit.fill,
                        width: (width) - 16,
                        height: (height * .3) - 16,
                      ),
                    );
                  },
                  itemCount: value.listImageBanner.length,
                  scrollDirection: Axis.horizontal,
                );
              },
            ),
          ),
          Container(
            width: width,
            height: height * .08,
            margin: const EdgeInsets.all(8),
            child: Consumer<CategoriesProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Provider.of<ShopProvider>(context, listen: false)
                            .getShops(value.listCategoriesModel[index].Id);
                      },
                      child: Container(
                        height: height * .08,
                        width: 100,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Text(value.listCategoriesModel[index].Name),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: value.listCategoriesModel.length,
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<ShopProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.listShopModel.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ItemScreen(
                                idShop: value.listShopModel[index].id,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              value.listShopModel[index].imageUrl,
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              value.listShopModel[index].name,
                            ),
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
