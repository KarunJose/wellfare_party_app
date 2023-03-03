import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wellfare_party_app/api/position_api.dart';
import 'package:wellfare_party_app/models/position_model.dart';

class PositionProvider extends ChangeNotifier {
  List<Position> positions = [];

  bool loading = false;

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  getPositions() async {
    toggleloading(true);
    positions = [Position(id: "-1", position: "Select Position")];

    var response = await fetchPositionsAPI();

    var responseJson = response.data;

    for (var pos in responseJson['positions']) {
      positions.add(Position.fromJson(pos));
    }

    toggleloading(false);
  }
}
