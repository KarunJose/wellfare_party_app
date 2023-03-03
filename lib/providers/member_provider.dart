import 'package:flutter/foundation.dart';
import 'package:wellfare_party_app/api/member_api.dart';
import 'package:wellfare_party_app/models/member_model.dart';

class MemberProvder extends ChangeNotifier {
  int maleMembersCount = 0;
  int femaleMembersCount = 0;
  int totalMemberCount = 0;

  int malePrimaryMembersCount = 0;
  int femalePrimaryMembersCount = 0;
  int totalPrimaryMembersCount = 0;

  List<Member> members = [];
  List<Member> primaryMembers = [];
  dynamic memberDropdownValue = 'Select Member';
  String? statusDropDown = 'Active';
  String? memberTypeDropDown = 'Select Member Type';
  String? genderDropdownValue = "Select Gender";
  List<String> memberType = [
    'Select Member Type',
    'Primary Member',
    'Member',
  ];
  List<String> status = [
    'Active',
    'Inactive',
  ];

  List<String> gender = [
    'Select Gender',
    'Male',
    'Female',
  ];

  bool loading = false;

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  resetData() {
    memberDropdownValue = 'Select Member';
    statusDropDown = 'Active';
    memberTypeDropDown = 'Select Member Type';
    genderDropdownValue = 'Select Gender';
    members = [];
    primaryMembers = [];
    notifyListeners();
  }

  selectGenderType(genterType) {
    genderDropdownValue = genterType;
    notifyListeners();
  }

  selectMemberType(membType) {
    memberTypeDropDown = membType;
    notifyListeners();
  }

  selectStatus(stat) {
    statusDropDown = stat;
    notifyListeners();
  }

  selectMember(memb) {
    memberDropdownValue = memb;
    notifyListeners();
  }

  getMemberCount() async {
    toggleloading(true);
    var response = await getMemberCountAPI();
    var responseJson = response.data;

    femaleMembersCount = responseJson["female_members"];
    maleMembersCount = responseJson["male_members"];
    totalMemberCount = responseJson["total_members"];

    malePrimaryMembersCount = responseJson["male_primary_members"];
    femalePrimaryMembersCount = responseJson["female_primary_members"];
    totalPrimaryMembersCount = responseJson["total_primary_members"];

    toggleloading(false);
  }

  getMembers({
    required String? memberType,
    String? gender,
    String? stateId,
    String? districtId,
    String? constId,
    String? panchayathId,
    String? wardId,
    String? unitId,
    String? name,
    String? phone,
    String? status,
  }) async {
    toggleloading(true);

    // Api req
    var response = await getMembersAPI(
      gender: gender != "Select Gender" ? gender : '',
      stateId: stateId != "Select State" ? stateId : '',
      districtId: districtId != "Select District" ? districtId : '',
      constId: constId != "Select Constituency" ? constId : '',
      panchayathId: panchayathId != "Select Panchayath" &&
              panchayathId != "Select Constituency"
          ? panchayathId
          : '',
      wardId: wardId != "Select Ward" ? wardId : '',
      unitId: unitId != "Select Unit" ? unitId : '',
      name: name,
      phone: phone,
      status: status == "Active"
          ? "1"
          : status == "Inactive"
              ? "0"
              : '',
      membertype: memberType == "primarymember"
          ? "Primary Member"
          : memberType == "member"
              ? "Member"
              : '',
    );
    // response json
    var responseJson = response.data;

    if (memberType == "primarymember") {
      primaryMembers = [];
    } else {
      members = [];
    }

    // json loop
    for (var memberjson in responseJson['members']) {
      Member tempPrimaryMember = Member.fromJson(memberjson);
      if (memberType == "primarymember") {
        primaryMembers.add(tempPrimaryMember);
      } else {
        members.add(tempPrimaryMember);
      }
    }

    // resetData();
    // statusDropDown = 'Select status';
    memberDropdownValue = 'Select Member';

    toggleloading(false);
  }

  // getPrimaryMembers({
  //   String? gender,
  //   String? stateId,
  //   String? districtId,
  //   String? constId,
  //   String? panchayathId,
  //   String? wardId,
  //   String? unitId,
  //   String? name,
  //   String? phone,
  //   String? status,
  // }) async {
  //   toggleloading(true);

  //   // Api req
  //   var response = await getMembersAPI(
  //       gender: gender,
  //       districtId: districtId,
  //       constId: constId,
  //       panchayathId: panchayathId,
  //       wardId: wardId,
  //       unitId: unitId,
  //       name: name,
  //       phone: phone,
  //       status: status,
  //       membertype: "Primary Member");
  //   // response json
  //   var responseJson = response.data;

  //   primaryMembers = [];
  //   // json loop
  //   for (var memberjson in responseJson['members']) {
  //     Member tempPrimaryMember = Member.fromJson(memberjson);
  //     primaryMembers.add(tempPrimaryMember);
  //   }

  //   // members insert
  //   resetData();

  //   toggleloading(false);
  // }

  addMember({
    required String name,
    required String dob,
    required String gender,
    required String age,
    required String blood,
    required String mobile,
    required String email,
    // required String positions,
    required String address,
    required bool isAgree,
    String? adminssionYear,
    String? participationDate,
    required String stateId,
    required String districtId,
    required String constituencyId,
    required String panchayathId,
    required String wardId,
    required String unitId,
    required int status,

    //String ward,
  }) async {
    toggleloading(true);
    var response = await createMemberAPI(
      name: name,
      dob: dob,
      gender: gender,
      age: age,
      blood: blood,
      mobile: mobile,
      email: email,
      // positions: positions,
      address: address,
      isAgree: isAgree,
      adminssionYear: adminssionYear,
      participationDate: participationDate,
      stateId: stateId,
      districtId: districtId,
      constituencyId: constituencyId,
      panchayathId: panchayathId,
      wardId: wardId,
      unitId: unitId,
      status: status,
    );

    // getMembers();
    // getPrimaryMembers();
    toggleloading(false);
  }

  updateMember({
    required String id,
    required String name,
    required String dob,
    required String gender,
    required String age,
    required String blood,
    required String mobile,
    required String email,
    // String positions,
    required String address,
    required bool isAgree,
    String? adminssionYear,
    String? participationDate,
    required String stateId,
    required String districtId,
    required String constituencyId,
    required String panchayathId,
    required String wardId,
    required String unitId,
    required int status,
  }) async {
    toggleloading(true);
    var response = await updateMemberAPI(
      id: id,
      status: status,
      name: name,
      dob: dob,
      gender: gender,
      age: age,
      blood: blood,
      mobile: mobile,
      email: email,
      // positions: positions,
      address: address,
      isAgree: isAgree,
      adminssionYear: adminssionYear,
      participationDate: participationDate,
      stateId: stateId,
      districtId: districtId,
      constituencyId: constituencyId,
      panchayathId: panchayathId,
      wardId: wardId,
      unitId: unitId,
    );

    // getMembers();
    // getPrimaryMembers();
    members = [];
    primaryMembers = [];

    toggleloading(false);
  }

  checkLoading() async {
    toggleloading(true);

    var pm = primaryMembers;

    primaryMembers = [];

    await Future.delayed(const Duration(seconds: 3), () {});

    primaryMembers = pm;

    toggleloading(false);
  }
}
