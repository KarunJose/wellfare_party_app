import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/api/bearer_report_api.dart';
import 'package:wellfare_party_app/api/hierarchi_info_api.dart';
import 'package:wellfare_party_app/models/constituency_model.dart';
import 'package:wellfare_party_app/models/district_model.dart';
import 'package:wellfare_party_app/models/hierarchiInfoModel.dart';
import 'package:wellfare_party_app/models/panchayath_model.dart';
import 'package:wellfare_party_app/models/state_model.dart';
import 'package:wellfare_party_app/models/unit_model.dart';
import 'package:wellfare_party_app/models/ward_model.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

class HeirarchyProvider extends ChangeNotifier {
  String stateDropDownValue = "Select State";
  bool stateInValid = false;
  String districtDropdownValue = "Select District";
  bool districtInValid = false;
  String constituencyDropdownValue = "Select Constituency";
  bool constituencyInValid = false;
  String panchayathDropdownValue = "Select Panchayath";
  bool panchayathInValid = false;
  String wardDropdownValue = "Select Ward";
  bool wardInvalid = false;
  String unitDropdownValue = "Select Unit";
  bool unitInvalid = false;

  bool all = false;

  List<HierarchyInfoModel> hierarchyinfolist = [];

  List<StateModel> state = [
    StateModel(stateName: "Select State", id: "Select State")
  ];

  List<DistrictModel> district = [
    DistrictModel(
        districtName: "Select District",
        districtId: "Select District",
        stateId: "")
  ];

  List<ConstituencyModel> constituency = [
    ConstituencyModel(
      constituencyName: "Select Constituency",
      id: "Select Constituency",
      districtId: "",
      stateId: "",
    )
  ];

  List<PanchayathModel> panchayath = [
    PanchayathModel(
      panchayathName: "Select Panchayath",
      id: "Select Panchayath",
      constituency: "",
      districtId: "",
      stateId: "",
    )
  ];

  List<Ward> ward = [
    Ward(
      id: "Select Ward",
      ward: "Select Ward",
      constituencyId: "",
      districtId: "",
      panchayathId: "",
      stateId: "",
      wardcorde: "",
    )
  ];

  List<UnitModel> unit = [
    UnitModel(
      id: "Select Unit",
      unitName: "Select Unit",
      constituencyId: "",
      districtId: "",
      panchayathId: "",
      stateId: "",
      wardId: "",
    )
  ];

  bool loading = false;

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  setStateError(bool error) {
    stateInValid = error;
    notifyListeners();
  }

  setDistrictError(bool error) {
    districtInValid = error;
    notifyListeners();
  }

  setConstituencyError(bool error) {
    constituencyInValid = error;
    notifyListeners();
  }

  setPanchayathError(bool error) {
    panchayathInValid = error;
    notifyListeners();
  }

  setUnitEror(bool error) {
    unitInvalid = error;
    notifyListeners();
  }

  checkDta() {
    bool error = false;

    if (stateDropDownValue == "Select State") {
      setStateError(true);
      error = true;
    } else {
      setStateError(false);
    }
    if (districtDropdownValue == "Select District") {
      setDistrictError(true);
      error = true;
    } else {
      setDistrictError(false);
    }
    if (constituencyDropdownValue == "Select Constituency") {
      setConstituencyError(true);
      error = true;
    } else {
      setConstituencyError(false);
    }
    if (panchayathDropdownValue == "Select Panchayath") {
      setPanchayathError(true);
      error = true;
    } else {
      setPanchayathError(false);
    }
    if (unitDropdownValue == "Select Unit") {
      setUnitEror(true);
      error = true;
    } else {
      setUnitEror(false);
    }
    return error;
  }

  resetData() {
    stateDropDownValue = "Select State";
    stateInValid = false;
    districtDropdownValue = "Select District";
    districtInValid = false;
    constituencyDropdownValue = "Select Constituency";
    constituencyInValid = false;
    panchayathDropdownValue = "Select Panchayath";
    panchayathInValid = false;
    wardDropdownValue = "Select Ward";
    wardInvalid = false;
    unitDropdownValue = "Select Unit";
    unitInvalid = false;
    notifyListeners();
  }

  selectState(stateId) {
    stateDropDownValue = stateId;
    notifyListeners();
  }

  selectDistrict(districtId) {
    districtDropdownValue = districtId;
    notifyListeners();
  }

  selectConstituency(constituencyId) {
    constituencyDropdownValue = constituencyId;
    notifyListeners();
  }

  selectPanchayath(panchayathId) {
    panchayathDropdownValue = panchayathId;
    notifyListeners();
  }

  selectWard(wardId) {
    wardDropdownValue = wardId;
    notifyListeners();
  }

  selectUnit(unitId) {
    unitDropdownValue = unitId;
    notifyListeners();
  }

  setAll(bool all) {
    this.all = all;
  }

  getState() async {
    toggleloading(true);

    state = [
      StateModel(stateName: "Select State", id: "Select State"),
    ];
    var response = await fetchStateAPI();

    var responseJson = response.data;

    for (var ste in responseJson['states']) {
      state.add(StateModel.fromJson(ste));
    }
    toggleloading(false);
  }

  getDistrict(String? stateId) async {
    toggleloading(true);
    district = [
      DistrictModel(
        districtName: "Select District",
        districtId: "Select District",
        stateId: "",
      )
    ];
    if (all == true) {
      district.add(DistrictModel(
        districtName: "All",
        districtId: "All",
        stateId: "",
      ));
    }
    if (stateId != 'All') {
      var response = await fetchDistrictAPi(stateId);

      var responseJson = response.data;

      for (var distr in responseJson['districts']) {
        district.add(DistrictModel.fromjson(distr));
      }
    }
    var response = await fetchDistrictAPi(stateId);

    var responseJson = response.data;

    for (var distr in responseJson['districts']) {
      district.add(DistrictModel.fromjson(distr));
    }
    toggleloading(false);
  }

  getConstituency(String? districtId) async {
    toggleloading(true);
    constituency = [
      ConstituencyModel(
        constituencyName: "Select Constituency",
        id: "Select Constituency",
        districtId: "",
        stateId: "",
      )
    ];
    if (all == true) {
      constituency.add(
        ConstituencyModel(
          constituencyName: "All",
          id: "All",
          districtId: "",
          stateId: "",
        ),
      );
    }

    if (districtId != 'All') {
      var response = await fetchConstituencyAPI(districtId);
      var responseJson = response.data;

      for (var consti in responseJson['constituencies']) {
        constituency.add(ConstituencyModel.fromJson(consti));
      }
    }

    toggleloading(false);
  }

  getPanchayth(String? constituencyId) async {
    toggleloading(true);
    panchayath = [
      PanchayathModel(
        panchayathName: "Select Panchayath",
        id: "Select Panchayath",
        constituency: "",
        districtId: "",
        stateId: "",
      )
    ];

    if (all == true) {
      panchayath.add(PanchayathModel(
        panchayathName: "All",
        id: "All",
        constituency: "",
        districtId: "",
        stateId: "",
      ));
    }

    if (constituencyId != 'All') {
      var response = await fetchPanchayathAPI(constituencyId);
      var responseJson = response.data;

      for (var panchyt in responseJson['panchayath']) {
        panchayath.add(PanchayathModel.fromJson(panchyt));
      }
    }

    toggleloading(false);
  }

  getWard(String? panchayathId) async {
    toggleloading(true);
    ward = [
      Ward(
        id: "Select Ward",
        ward: "Select Ward",
        constituencyId: "",
        districtId: "",
        panchayathId: "",
        stateId: "",
        wardcorde: "",
      )
    ];

    if (panchayathId != "All") {
      var response = await fetchWardAPI(panchayathId);
      var responseJson = response.data;

      for (var war in responseJson['wards']) {
        ward.add(Ward.fromJson(war));
      }
    }

    toggleloading(false);
  }

  getUnit(String? wardId) async {
    toggleloading(true);
    unit = [
      UnitModel(
        id: "Select Unit",
        unitName: "Select Unit",
        constituencyId: "",
        districtId: "",
        panchayathId: "",
        stateId: "",
        wardId: "",
      )
    ];

    // All condition
    if (all == true) {
      unit.add(UnitModel(
        id: "All",
        unitName: "All",
        constituencyId: "",
        districtId: "",
        panchayathId: "",
        stateId: "",
        wardId: "",
      ));
    }

    if (wardId != "All") {
      var response = await fetchUnitAPI(wardId);
      var responseJson = response.data;

      for (var uni in responseJson['units']) {
        unit.add(UnitModel.fromJson(uni));
      }
    }
    toggleloading(false);
  }

  setInitialData({all, edit, entity, context}) async {
    toggleloading(true);

    setAll(all);
    resetData();
    getState();

    final prefs = await SharedPreferences.getInstance();
    final user_type = prefs.getString('user_type');

    // setState(() {
    //   userType = user_type.toString();
    // });

    if (edit == true) {
      setEditBasedDropdownData(
        entity: entity,
      );
    } else {
      setLoginBasedDropdownData();
    }

    toggleloading(false);
  }

  setLoginBasedDropdownData() async {
    final prefs = await SharedPreferences.getInstance();
    final user_type = prefs.getString('user_type');
    final master_id = prefs.getString('master_id');

    print(master_id);

    // setState(() {
    //   userType = user_type.toString();
    // });

    if (user_type == "state") {
      // Set Selected state

      if (master_id != null) {
        await selectState(master_id);
      }

      getDistrict(master_id);
    } else if (user_type == "district") {
      await getDistrict(null);
      for (var distr in district) {
        if (distr.districtId == master_id) {
          await selectDistrict(distr.districtId);
          await selectState(distr.stateId);

          await getConstituency(distr.districtId);
        }
      }
    } else if (user_type == "constituency") {
      await getConstituency(null);
      await getDistrict(null);
      for (var constituency in constituency) {
        if (constituency.id == master_id) {
          await selectConstituency(constituency.id);
          await selectDistrict(constituency.districtId);
          await selectState(constituency.stateId);
          await getPanchayth(constituency.id);
        }
      }
    } else if (user_type == "panchayath") {
      await getPanchayth(null);
      await getConstituency(null);
      await getDistrict(null);
      for (var panchayath in panchayath) {
        if (panchayath.id == master_id) {
          await selectPanchayath(panchayath.id);
          await selectConstituency(panchayath.constituency);

          await selectDistrict(panchayath.districtId);
          await selectState(panchayath.stateId);

          await getWard(panchayath.id);
        }
      }
    } else if (user_type == "ward") {
      await getWard(null);
      await getPanchayth(null);
      await getConstituency(null);
      await getDistrict(null);
      for (var ward in ward) {
        if (ward.id == master_id) {
          await selectWard(ward.id);
          await selectPanchayath(ward.panchayathId);
          await selectConstituency(ward.constituencyId);
          await selectDistrict(ward.districtId);
          await selectState(ward.stateId);

          await getUnit(ward.id);
        }
      }
    } else if (user_type == "unit") {
      await getUnit(null);
      await getWard(null);
      await getPanchayth(null);
      await getConstituency(null);
      await getDistrict(null);
      for (var unit in unit) {
        if (unit.id == master_id) {
          await selectUnit(unit.id);
          await selectWard(unit.wardId);
          await selectPanchayath(unit.panchayathId);
          await selectConstituency(unit.constituencyId);
          await selectDistrict(unit.districtId);
          await selectState(unit.stateId);
        }
      }
    }
  }

  setEditBasedDropdownData({entity}) async {
    if (entity != null) {
      await selectState(entity.stateId);

      await getDistrict(entity.stateId);
      await selectDistrict(entity.districtId);

      await getConstituency(entity.districtId);
      await selectConstituency(entity.constituencyId);

      await getPanchayth(entity.constituencyId);
      await selectPanchayath(entity.panchayathId);

      await getUnit(entity.panchayathId);
      await selectUnit(entity.unitId);
    } else {
      // show snackbar - dev data - no entity received
      // showSnackbar(context: context, text: "No entity received.");
    }
  }

  gethierarchyInfo() async {
    toggleloading(true);
    hierarchyinfolist = [];

    var response = await hierarchyInfoAPI();
    var responseJson = response.data;
    for (var hirarchyInfo in responseJson["result"]) {
      hierarchyinfolist.add(HierarchyInfoModel.fromJson(hirarchyInfo));
    }
    toggleloading(false);
  }
}
