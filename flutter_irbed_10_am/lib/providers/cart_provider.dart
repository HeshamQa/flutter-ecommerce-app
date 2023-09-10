import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../const_values.dart';
import '../general.dart';
import '../models/cart_model.dart';


class CartProv extends ChangeNotifier {
  List<CartModel> listCartModel = [];
  double totalPrice = 0;

  getCart() async {
    EasyLoading.show(status: 'loading...');
    listCartModel = [];
    totalPrice = 0;
    General.getPrefString(ConsValues.ID, "").then(
          (idUser) async {
        final response = await http.post(
          Uri.parse(
            "${ConsValues.BASEURL}getCart.php",
          ),
          body: {
            "Id_users": idUser,
          },
        );
        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          var cart = jsonBody['cart'];
          for (Map i in cart) {
            listCartModel.add(CartModel.fromJson(i));
            totalPrice = totalPrice + i['Price'] * i['Count'];
          }
          notifyListeners();
        }
      },
    );
  }

  addToCart({required var idItem}) async {
    EasyLoading.show(status: 'loading...');
    General.getPrefString(ConsValues.ID, "").then(
          (idUser) async {
        await http.post(
          Uri.parse("${ConsValues.BASEURL}addToCart.php"),
          body: {
            "Id_users": idUser,
            "Id_items": idItem,
          },
        );
        EasyLoading.dismiss();
      },
    );
  }

  updateItemCount(var id, var count,var index) async {

    EasyLoading.show(status: 'loading...');
    //General.getPrefString(ConsValues.ID, "").then(
    //(idUser) async {
      if (count <= 0) {
        deleteItemFromCart(id);
        listCartModel.removeAt(index);
      }
      else {
        final response = await http.post(
          Uri.parse("${ConsValues.BASEURL}updateCart.php"),
          body: {
            "Id": id,
            "Count": count.toString(),
          },
        );

        listCartModel[index].Count = count;

        totalPrice = 0;
        for (CartModel cartModel in listCartModel) {
          totalPrice = totalPrice + cartModel.Price * cartModel.Count;
        }
      }
    // },);

        EasyLoading.dismiss();
        notifyListeners();
  }

 deleteItemFromCart(var id) async{

   final response = await http.post(
     Uri.parse("${ConsValues.BASEURL}deleteCart.php"),
     body: {
       "Id": id,
     },
   );
 }
  }

