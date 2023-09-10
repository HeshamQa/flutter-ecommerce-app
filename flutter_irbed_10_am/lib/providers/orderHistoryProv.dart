import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';
import 'package:flutter_irbed_10_am/general.dart';
import 'package:http/http.dart' as http;

import '../models/orderHistory_model.dart';

class OrderHistoryProv extends ChangeNotifier {
  List<OrderHistoryModel> listOrderHistoryModel = [];

  getOrderHistory() async {
    EasyLoading.show(status: 'loading...');
    listOrderHistoryModel = [];
    General.getPrefString(ConsValues.ID, "").then(
      (idUser) async {
        final response = await http.post(
          Uri.parse("${ConsValues.BASEURL}getOrderHistory.php"),
          body: {
            "Id_users": idUser,
          },
        );
        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          var orders = jsonBody['orders'];
          for (Map i in orders) {
            listOrderHistoryModel.add(OrderHistoryModel.fromJson(i));
          }
          notifyListeners();
        }
      },
    );
  }
}
