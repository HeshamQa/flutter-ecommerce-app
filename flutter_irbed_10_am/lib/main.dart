import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/providers/banner_provider.dart';
import 'package:flutter_irbed_10_am/providers/cart_provider.dart';
import 'package:flutter_irbed_10_am/providers/categories_provider.dart';
import 'package:flutter_irbed_10_am/providers/item_image_prov.dart';
import 'package:flutter_irbed_10_am/providers/items_prov.dart';
import 'package:flutter_irbed_10_am/providers/orderHistoryDetailsProv.dart';
import 'package:flutter_irbed_10_am/providers/orderHistoryProv.dart';
import 'package:flutter_irbed_10_am/providers/shop_provider.dart';
import 'package:flutter_irbed_10_am/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BannerProvider>(
          create: (_) => BannerProvider(),
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (_) => CategoriesProvider(),
        ),
        ChangeNotifierProvider<ShopProvider>(
          create: (_) => ShopProvider(),
        ),
        ChangeNotifierProvider<ItemProv>(
          create: (_) => ItemProv(),
        ),
        ChangeNotifierProvider<ItemImageProv>(
          create: (_) => ItemImageProv(),
        ),
        ChangeNotifierProvider<CartProv>(
          create: (_) => CartProv(),
        ),
        ChangeNotifierProvider<OrderHistoryProv>(
          create: (_) => OrderHistoryProv(),
        ),
        ChangeNotifierProvider<OrderHistoryDetailsProv>(
          create: (_) => OrderHistoryDetailsProv(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
