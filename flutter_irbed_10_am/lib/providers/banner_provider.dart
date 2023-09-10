import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_irbed_10_am/const_values.dart';

import '../models/image_banner.dart';
import 'package:http/http.dart' as http;

class BannerProvider extends ChangeNotifier {
  List<ImageBanner> listImageBanner = [];

  getBannerImages() async {
    EasyLoading.show(status: 'loading...');

    final response =
        await http.get(Uri.parse("${ConsValues.BASEURL}getBannerImages.php"));
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var bannerImages = jsonBody['bannerImages'];

      for (Map i in bannerImages) {
        listImageBanner.add(ImageBanner.fromJson(i));
      }
      notifyListeners();
    }
  }

  Future addNewBanner({required File image, required String url}) async {
    EasyLoading.show(status: 'loading...');
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewBanner.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload", image.path);
    request.fields['URL'] = url;
    request.files.add(pic);

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listImageBanner.add(
      ImageBanner(
        Id: data['Id'],
        URL: data['URL'],
        ImageUrl: data['ImageURL'],
      ),
    );
    notifyListeners();
    EasyLoading.dismiss();
  }
}
