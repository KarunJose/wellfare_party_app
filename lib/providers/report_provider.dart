import 'package:flutter/foundation.dart';
import 'package:wellfare_party_app/api/bearer_report_api.dart';
import 'package:wellfare_party_app/models/constituency_model.dart';
import 'package:wellfare_party_app/models/designation_model.dart';
import 'package:wellfare_party_app/models/district_model.dart';
import 'package:wellfare_party_app/models/panchayath_model.dart';
import 'package:wellfare_party_app/models/report_model.dart';
import 'package:wellfare_party_app/models/subcommitee_model.dart';
import 'package:wellfare_party_app/models/subcommittee_report_model.dart';
import 'package:wellfare_party_app/models/unit_model.dart';
import 'package:wellfare_party_app/models/ward_model.dart';

import '../models/state_model.dart';

class ReportProvider extends ChangeNotifier {
  List<SubCommitteeModel> subcommittee = [
    SubCommitteeModel(id: "All", subCommitteeName: "All")
  ];

  List<Designation> designations = [
    Designation(designationName: "Select Designation", id: "Select Designation")
  ];

  List<StateModel> state = [StateModel(stateName: "All", id: "All")];

  List<DistrictModel> district = [
    DistrictModel(districtName: "All", districtId: "All", stateId: "")
  ];

  List<ConstituencyModel> constituency = [
    ConstituencyModel(
      constituencyName: "All",
      id: "All",
      districtId: "",
      stateId: "",
    )
  ];

  List<PanchayathModel> panchayath = [
    PanchayathModel(
      panchayathName: "All",
      id: "All",
      constituency: "",
      districtId: "",
      stateId: "",
    )
  ];

  List<Ward> ward = [
    Ward(
      id: "All",
      ward: "All",
      constituencyId: "",
      districtId: "",
      panchayathId: "",
      stateId: "",
      wardcorde: "",
    )
  ];

  List<UnitModel> unit = [
    UnitModel(
      id: "All",
      unitName: "All",
      constituencyId: "",
      districtId: "",
      panchayathId: "",
      stateId: "",
      wardId: "",
    )
  ];

  List<ReportModel> reportResults = [];
  bool loading = false;

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  getSubcommittee() async {
    toggleloading(true);
    subcommittee = [SubCommitteeModel(id: "All", subCommitteeName: "All")];
    var response = await fetchSubcommitteeAPI();
    var responseJson = response.data;
    for (var subcom in responseJson['sub_committee']) {
      subcommittee.add(SubCommitteeModel.fromJson(subcom));
    }
    toggleloading(false);
  }

  getDesignation() async {
    toggleloading(true);
    designations = [
      Designation(
          designationName: "Select Designation", id: "Select Designation")
    ];

    var response = await fetchDesignationAPI();

    var responseJson = response.data;
    for (var desig in responseJson['designations']) {
      designations.add(Designation.fromJson(desig));
    }
    toggleloading(false);
  }

  getState() async {
    toggleloading(true);
    state = [StateModel(stateName: "All", id: "All")];
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
        districtName: "All",
        districtId: "All",
        stateId: "",
      )
    ];
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
        constituencyName: "All",
        id: "All",
        districtId: "",
        stateId: "",
      )
    ];
    var response = await fetchConstituencyAPI(districtId);
    var responseJson = response.data;

    for (var consti in responseJson['constituencies']) {
      constituency.add(ConstituencyModel.fromJson(consti));
    }
    toggleloading(false);
  }

  getPanchayth(String? constituencyId) async {
    toggleloading(true);
    panchayath = [
      PanchayathModel(
        panchayathName: "All",
        id: "All",
        constituency: "",
        districtId: "",
        stateId: "",
      )
    ];

    var response = await fetchPanchayathAPI(constituencyId);
    var responseJson = response.data;

    for (var panchyt in responseJson['panchayath']) {
      panchayath.add(PanchayathModel.fromJson(panchyt));
    }
    toggleloading(false);
  }

  getWard(String? panchayathId) async {
    toggleloading(true);
    ward = [
      Ward(
        id: "All",
        ward: "All",
        constituencyId: "",
        districtId: "",
        panchayathId: "",
        stateId: "",
        wardcorde: "",
      )
    ];

    var response = await fetchWardAPI(panchayathId);
    var responseJson = response.data;

    for (var war in responseJson['wards']) {
      ward.add(Ward.fromJson(war));
    }
    toggleloading(false);
  }

  getUnit(String? wardId) async {
    toggleloading(true);
    unit = [
      UnitModel(
        id: "All",
        unitName: "All",
        constituencyId: "",
        districtId: "",
        panchayathId: "",
        stateId: "",
        wardId: "",
      )
    ];

    var response = await fetchUnitAPI(wardId);
    var responseJson = response.data;

    for (var uni in responseJson['units']) {
      unit.add(UnitModel.fromJson(uni));
    }
    toggleloading(false);
  }

  getReport(
      String stateId,
      String districtId,
      String constituencyId,
      String panchayathId,
      String wardId,
      String unitId,
      String designationId) async {
    toggleloading(true);
    reportResults = [];
    var response = await fetchBearerReportResultAPI(stateId, districtId,
        constituencyId, panchayathId, wardId, unitId, designationId);
    var responseJson = response.data;
    for (var repo in responseJson['list']) {
      reportResults.add(ReportModel.fromJson(repo));
    }
    toggleloading(false);
  }

  getSubcommitteeReport(
    String stateId,
    String districtId,
    String constituencyId,
    String panchayathId,
    String wardId,
    String unitId,
    String designationId,
    String subcommitteeId,
  ) async {
    toggleloading(true);
    reportResults = [];
    var response = await fetchBearerSubcommitteeResultAPI(
        stateId,
        districtId,
        constituencyId,
        panchayathId,
        designationId,
        wardId,
        unitId,
        subcommitteeId);
    var responseJson = response.data;
    for (var subrepo in responseJson['list']) {
      reportResults.add(ReportModel.fromJson(subrepo));
    }
    toggleloading(false);
  }
}
