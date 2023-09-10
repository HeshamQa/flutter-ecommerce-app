import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';
import 'package:flutter_irbed_10_am/models/item_model.dart';
import 'package:http/http.dart' as http;

import '../models/orderHistory_model.dart';

class ItemProv extends ChangeNotifier {
  List<ItemModel> listItemModel = [];

  getItems({required var idShop}) async {
    EasyLoading.show(status: 'loading...');
    listItemModel = [];
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}getItems.php"),
      body: {
        "Id_shops": idShop,
      },
    );
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var items = jsonBody['items'];
      for (Map i in items) {
        listItemModel.add(ItemModel.fromJson(i));
      }
      notifyListeners();
    }
  }


}
