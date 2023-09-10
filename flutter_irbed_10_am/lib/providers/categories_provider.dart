import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../const_values.dart';
import '../general.dart';
import '../models/categories_model.dart';

class CategoriesProvider extends ChangeNotifier {
  List<CategoriesModel> listCategoriesModel = [];
  List<CategoriesModel> listCategoriesModelAdmin = [];

  getCategories() async {
    final response = await http.get(
      Uri.parse("${ConsValues.BASEURL}getCategories.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['categories'];
      for (Map i in categories) {
        listCategoriesModel.add(CategoriesModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  getAdminCategories() async {
    listCategoriesModelAdmin = [];
    final response = await http.get(
      Uri.parse("${ConsValues.BASEURL}getCategoriesAdmin.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['Categories'];
      for (Map i in categories) {
        listCategoriesModelAdmin.add(CategoriesModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  AdminAddNewCategories({required int Id_statustypes,required String Name,}) async {
    EasyLoading.show(status: 'loading...');
    General.getPrefString(ConsValues.ID, "").then(
          (idUser) async {
        await http.post(
          Uri.parse("${ConsValues.BASEURL}addNewCategory.php"),
          body: {
            "Name": Name,
            "Id_statustypes": Id_statustypes.toString(),
          },
        );
        notifyListeners();
        EasyLoading.dismiss();
      },
    );
  }
}