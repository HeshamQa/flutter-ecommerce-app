import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';
import 'package:flutter_irbed_10_am/models/shop_model.dart';
import 'package:http/http.dart' as http;

class ShopProvider extends ChangeNotifier {
  List<ShopModel> listShopModel = [];

  getShops(var id_category) async {
    EasyLoading.show(status: 'loading...');
    listShopModel = [];
    final response = await http.post(
      Uri.parse(ConsValues.BASEURL + "getShops.php"),
      body: {
        "Id_Categories": id_category,
      },
    );
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var shops = jsonBody['shops'];
      for (Map i in shops) {
        listShopModel.add(ShopModel.fromJson(i));
      }
      notifyListeners();
    }
  }
}
