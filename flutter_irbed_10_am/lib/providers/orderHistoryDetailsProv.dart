import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';
import 'package:flutter_irbed_10_am/general.dart';
import 'package:http/http.dart' as http;

import '../models/orderHistoryDetailsModel.dart';
import '../models/orderHistory_model.dart';

class OrderHistoryDetailsProv extends ChangeNotifier {
  List<OrderHistoryDetailsModel> listOrderHistoryDetailsModel = [];

  getOrderHistoryDet(var Id_orders) async {
    EasyLoading.show(status: 'loading...');
    listOrderHistoryDetailsModel = [];

        final response = await http.post(
          Uri.parse("${ConsValues.BASEURL}getOrderHistoryDetails.php"),
          body: {
            "Id_orders": Id_orders,
          },
        );
        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          var details = jsonBody['details'];
          for (Map i in details) {
            listOrderHistoryDetailsModel.add(OrderHistoryDetailsModel.fromJson(i));
          }
          notifyListeners();
        }

  }
}
