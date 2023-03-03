import 'package:flutter/foundation.dart';
import 'package:wellfare_party_app/api/ward_api.dart';

import '../models/ward_model.dart';

class WardProvider extends ChangeNotifier {
  List<Ward> wards = [];

  bool loading = false;
  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  getWard() async {
    toggleloading(true);
    wards = [
      Ward(
        id: "-1",
        ward: "Select Ward",
        wardcorde: "",
        constituencyId: "",
        districtId: "",
        panchayathId: "",
        stateId: "",
      )
    ];
    var response = await fetchWardAPI();
    var responseJson = response.data;

    if (responseJson['status'] == true) {
      for (var ward in responseJson['wards']) {
        wards.add(
          Ward.fromJson(ward),
        );
      }
    }
    toggleloading(false);
  }
}
