import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/user_api.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;

  bool error = false;

  String role = "";

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  signIn(String username, String password) async {
    toggleloading(true);
    // Request to server
    var response = await signInAPI(username, password);
    // Response status code 200
    // Standard flow
    // if (response.statusCode == 200) {
    //   print(response.data);
    // } else {
    //   print("login fail");
    // }

    if (response.statusCode == 200) {
      // var responseJson = jsonDecode(response.data);
      var responseJson = response.data;

      if (responseJson['status'] == true) {
        // print("succes5s");
        // set flag true
        error = false;
        // Store data to local
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("user_id", responseJson['id'].toString());
        prefs.setString("role_name", responseJson['role_name'].toString());
        prefs.setString('title', responseJson['name'].toString());

        prefs.setString('subtitle', responseJson['address'].toString());
        prefs.setString('user_type', responseJson['user_type'].toString());
        prefs.setString('master_id', responseJson['master_id'].toString());

        prefs.setString('state_id', responseJson['state_id'].toString());
        prefs.setString('district_id', responseJson['district_id'].toString());
        prefs.setString(
            'constituency_id', responseJson['constituency_id'].toString());
        prefs.setString(
            'panchayath_id', responseJson['panchayath_id'].toString());
        prefs.setString('ward_id', responseJson['ward_id'].toString());
        prefs.setString('unit_id', responseJson['unit_id'].toString());

        role = responseJson['role_name'];
      } else {
        // print("Fail");
        error = true;
      }
    }

    toggleloading(false);
    return error;
  }

  updateProfileName(String updatedProfileName) async {
    updateProfileNameAPI(updatedProfileName);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('title', updatedProfileName);
  }

  setRole(String role) {
    this.role = role;
    notifyListeners();
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
