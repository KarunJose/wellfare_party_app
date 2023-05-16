

import 'package:flutter/material.dart';
import 'package:wellfare_party_app/models/unit_model.dart';

import '../api/unit_api.dart';

class UnitProvider extends ChangeNotifier {
  bool loading = false;
  List<UnitModel> unitList = [];

   toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  getUnitList() async {
    toggleloading(true);
    var response = await getUnitAPI();
    var responseJson = response.data;
    for (var unit in responseJson["units"]) {
      unitList.add(UnitModel.fromJson(unit));
    }
    toggleloading(false);
  }
}