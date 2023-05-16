

import 'package:flutter/material.dart';
import 'package:wellfare_party_app/api/panchayat_api.dart';
import 'package:wellfare_party_app/models/panchayath_model.dart';

class PanchayatProvider extends ChangeNotifier {
  bool loading = false;
  List<PanchayathModel> panchayatList = [];

   toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  getPanchayatList() async {
    toggleloading(true);
    var response = await getPanchayatAPI();
    var responseJson = response.data;
    for (var panchayat in responseJson["panchayath"]) {
      panchayatList.add(PanchayathModel.fromJson(panchayat));
    }
    toggleloading(false);
  }
}