

import 'package:flutter/material.dart';
import 'package:wellfare_party_app/api/constituency_api.dart';
import 'package:wellfare_party_app/models/constituency_model.dart';

class ConstituencyProvider extends ChangeNotifier {
  bool loading = false;
  List<ConstituencyModel> constituencyList = [];

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }
   
   getConstituencyList() async {
     toggleloading(true);
     var response = await getConstituencyAPI(
     );
     var responseJson = response.data;
     for (var constituency in responseJson["constituencies"]) {
      constituencyList.add(ConstituencyModel.fromJson(constituency));
   } 
   toggleloading(false);
   } 
}
