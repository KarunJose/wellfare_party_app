import 'package:flutter/cupertino.dart';
import 'package:wellfare_party_app/api/loginUser_api.dart';
import 'package:wellfare_party_app/models/loginUserModel.dart';
import 'package:wellfare_party_app/models/member_model.dart';
import 'package:wellfare_party_app/models/user_role_model.dart';

import '../api/user_role_api.dart';

class UserRoleProvider extends ChangeNotifier {
  List<LoginUserModel> loginUsers = [];

  List<String> organizationlevel = [
    'Select user type',
    'State',
    'District',
    'Constituency',
    'Panchayath',
    'Ward',
    'Unit',
  ];

  List<String> status = [
    'Select status',
    'Active',
    'Inactive',
  ];

  List<UserRoleModel> userRoles = [
    UserRoleModel(
      id: "",
      name: "Select User Role",
      status: "",
      usertype: "",
      display: "",
      dateTime: DateTime(0),
    )
  ];

  UserRoleModel? userRoleDropDownValue;
  bool userRoleInvalid = false;
  String organizationLevelDropdownValue = 'Select user type';
  Member? memberDropdownValue;
  bool memberInvalid = false;
  String? statusDropDown = 'Select status';
  bool statusInvalid = false;

  bool loading = false;

  checkUserRoleAndMember() {
    if (memberDropdownValue == null || memberDropdownValue!.id == "") {
      memberInvalid = true;
    }

    if (userRoleDropDownValue == null || userRoleDropDownValue!.id == "") {
      userRoleInvalid = true;
    }
    notifyListeners();
    return memberInvalid || userRoleInvalid;
  }

  checkstatus() {
    if (statusDropDown == "Select Designation") {
      statusInvalid = true;

      notifyListeners();
      return true;
    }
    return false;
  }

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  resetData() {
    userRoleDropDownValue = userRoles.first;
    userRoleInvalid = false;
    memberDropdownValue = null;
    memberInvalid = false;
    statusDropDown = "Select status";
    notifyListeners();
  }

  fetchUserRoles() async {
    userRoles = [
      UserRoleModel(
        id: "",
        name: "Select User Role",
        status: "",
        usertype: "",
        display: "",
        dateTime: DateTime(0),
      )
    ];

    var response = await fetchUserRoleApi();

    var responseJson = response.data;
    for (var role in responseJson['roles']) {
      userRoles.add(UserRoleModel.fromJson(role));
    }

    userRoleDropDownValue = userRoles[0];
    notifyListeners();
  }

  selectUserRole(urol) {
    userRoleDropDownValue = urol;
    notifyListeners();
  }

  selectOrganizationlevel(orglevel) {
    organizationLevelDropdownValue = orglevel;
    notifyListeners();
  }

  selectMember(memb) {
    memberDropdownValue = memb;
    notifyListeners();
  }

  selectStatus(stat) {
    statusDropDown = stat;
    notifyListeners();
  }

  getLoginUsers() async {
    toggleloading(true);

    loginUsers = [];
    notifyListeners();

    var response = await fetchLoginUserAPI();

    var responseJson = response.data;

    if (responseJson['status'] == true) {
      for (var ward in responseJson['users']) {
        loginUsers.add(
          LoginUserModel.fromJson(ward),
        );
      }
    }

    toggleloading(false);
  }

  save({
    stateDropDownValue,
    districtDropdownValue,
    constituencyDropdownValue,
    panchayathDropdownValue,
    wardDropdownValue,
    unitDropdownValue,
    username,
    password,
  }) async {
    await createLoginUserAPI(
      memberId: memberDropdownValue!.id,
      password: password,
      role: userRoleDropDownValue!.id,
      stateId: stateDropDownValue != "All" ? stateDropDownValue : null,
      unitId: unitDropdownValue != "All" ? unitDropdownValue : null,
      wardId: wardDropdownValue != "All" ? wardDropdownValue : null,
      districtId: districtDropdownValue != "All" ? districtDropdownValue : null,
      constituencyId:
          constituencyDropdownValue != "All" ? constituencyDropdownValue : null,
      panchayathId:
          panchayathDropdownValue != "All" ? panchayathDropdownValue : null,
      username: username,
      status: statusDropDown,
    );

    getLoginUsers();
  }

  update({
    stateDropDownValue,
    districtDropdownValue,
    constituencyDropdownValue,
    panchayathDropdownValue,
    wardDropdownValue,
    unitDropdownValue,
    username,
    password,
    memberid,
    memberLoginId,
  }) async {
    await updateLoginUserAPI(
      memberId: memberid,
      memberLoginId: memberLoginId,
      password: password,
      role: userRoleDropDownValue!.id,
      stateId: stateDropDownValue != "All" ? stateDropDownValue : null,
      unitId: unitDropdownValue != "All" ? unitDropdownValue : null,
      wardId: wardDropdownValue != "All" ? wardDropdownValue : null,
      districtId: districtDropdownValue != "All" ? districtDropdownValue : null,
      constituencyId:
          constituencyDropdownValue != "All" ? constituencyDropdownValue : null,
      panchayathId:
          panchayathDropdownValue != "All" ? panchayathDropdownValue : null,
      username: username,
      status: statusDropDown == "Active" ? "1" : "0",
    );
    getLoginUsers();
  }
}
