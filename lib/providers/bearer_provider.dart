import 'package:flutter/foundation.dart';
import 'package:wellfare_party_app/api/bearer_api.dart';
import 'package:wellfare_party_app/models/member_model.dart';
import 'package:wellfare_party_app/models/officebearer_list_model.dart';

class BearerProvider extends ChangeNotifier {
  bool loading = false;
  List<OfficeBearerListModel> bearerList = [];
  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  String? statusDropDown = 'Active';
  List<String> status = [
    'Active',
    'Inactive',
  ];

  List<String> bearerTypes = [
    'Select Bearer Type',
    'State',
    'District',
    'Constituency',
    'Panchayath',
    'Ward',
    'Unit',
  ];

  List<String> interestedAreas = [
    "Select Interested Area",
    "ECONOMICS",
    "SOCIAL SCIENCE",
    "AGRICULTRE",
    "CULTURAL",
    "LAW",
    "PSCHOLOGY",
    "HISTORY",
    "THEOLOGY",
    "Education",
    "Philosophy",
    "Politics",
    "Development",
    "Transportation",
    "Other",
  ];

  List<String> languages = [
    "Select languages",
    "Malayalam",
    "English",
    "Arabic",
    "Hindi",
    "Urdu",
    "Other",
  ];

  List<String> educationalQualification = [
    "Select Education Qualification",
    "BELOW SSLC",
    "SSLC",
    "PLUS TWO",
    "DIPLOMA/ITI",
    "GRADUATION ",
    "POST GRADUTION and above",
  ];

  List<String> jobs = [
    "Select Job",
    "BUSINESS",
    "MERCHANT",
    "LABOUR",
    "AIDED SCHOOL",
    "GOVT RETIRED",
    "DRIVER",
    "AGRICULTURE",
    "PRIVATE",
    "Other",
  ];

  String bearerTypeDropdownValue = "Select Bearer Type";

  String designationDropDownValue = "Select Designation";
  bool designationInvalid = false;

  String selectedMemberdrpodownValue = "Select Member";
  bool selectMemberInvalid = false;

  String selectedEducationalQualification = "Select Education Qualification";
  bool educationalQualificationInvalid = false;

  List<String> selectedInterestedAreas = [];
  bool selectedIntrestedAreaInvalid = false;

  List<String> selectedLanguages = [];
  bool languageInvalid = false;

  String selectedJob = "Select Job";
  bool jobInvalid = false;

  List<Member> selectedMembers = [];

  String otherInterestedArea = "";

  String otherLanguage = "";

  String otherJob = "";

  String ayodhanakala = "No";
  String facebook = "No";
  String writer = "No";
  String instagram = "No";
  String igactive = "No";
  String twitter = "No";
  String twitteractive = "No";
  String publicspeech = "No";
  String studyclass = "No";
  String poemstory = "No";
  String slogan = "No";
  String service = "No";
  String counselling = "No";
  String publicrelation = "No";
  String opportunityfinder = "No";
  String organize = "No";
  String teamwork = "No";
  String motivation = "No";

  setselectedBearerType(val) {
    bearerTypeDropdownValue = val;
    notifyListeners();
  }

  resetdata() {
    statusDropDown = 'Active';
    bearerTypeDropdownValue = "Select Bearer Type";
    selectedMemberdrpodownValue = "Select Member";
    designationDropDownValue = "Select Designation";
    selectedInterestedAreas = [];
    selectedLanguages = [];
    selectedEducationalQualification = "Select Education Qualification";
    designationInvalid = false;
    selectedIntrestedAreaInvalid = false;
    selectMemberInvalid = false;
    educationalQualificationInvalid = false;
    jobInvalid = false;
    selectedJob = "Select Job";
    bearerList = [];
    notifyListeners();
  }

  selectStatus(stat) {
    statusDropDown = stat;
    notifyListeners();
  }

  checkdesignation() {
    if (designationDropDownValue == "Select Designation") {
      designationInvalid = true;

      notifyListeners();
      return true;
    }
    return false;
  }

  checkMember() {
    if (selectedMemberdrpodownValue == "Select Member") {
      selectMemberInvalid = true;

      notifyListeners();
      return true;
    }
    return false;
  }

  checkIntrestedArea() {
    if (selectedInterestedAreas.length == 0) {
      selectedIntrestedAreaInvalid = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  checkEducationalQualification() {
    if (selectedEducationalQualification == "Select Education Qualification") {
      educationalQualificationInvalid = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  checkJob() {
    if (selectedJob == "Select Job") {
      jobInvalid = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  checkLanguage() {
    if (selectedLanguages.length == 0) {
      languageInvalid = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  getSelectedBearerIndex() {
    return bearerTypes.indexOf(bearerTypeDropdownValue);
  }

  setdesignationDropDownValue(val) {
    designationDropDownValue = val;
    notifyListeners();
  }

  setselectedMember(val) {
    selectedMemberdrpodownValue = val;
    notifyListeners();
  }

  addToSelectedMembers(Member member) {
    if (!selectedMembers.contains(member)) {
      selectedMembers.add(member);
    }
    notifyListeners();
  }

  removeFromSelectedMembers(Member member) {
    selectedMembers.removeWhere((element) => element.id == member.id);
    notifyListeners();
  }

  addToSelectedInterestedAreas(String val) {
    if (!selectedInterestedAreas.contains(val)) {
      selectedInterestedAreas.add(val);
    }
    notifyListeners();
  }

  removeFromSelectedInterestedAreas(String val) {
    selectedInterestedAreas.removeWhere((element) => element == val);
    notifyListeners();
  }

  setOtherInterestedAreas(String val) {
    otherInterestedArea = val;
    notifyListeners();
  }

  addToSelectedLanguage(String val) {
    if (!selectedLanguages.contains(val)) {
      selectedLanguages.add(val);
    }
    notifyListeners();
  }

  removeFromSelectedLanguage(String val) {
    selectedLanguages.removeWhere((element) => element == val);
    notifyListeners();
  }

  setOtherLanguage(String val) {
    otherLanguage = val;
    notifyListeners();
  }

  setselectedEducationalQualification(String val) {
    selectedEducationalQualification = val;
    notifyListeners();
  }

  setselectedJob(String val) {
    selectedJob = val;
    notifyListeners();
  }

  setOtherJob(String val) {
    otherJob = val;
    notifyListeners();
  }

  setayodhanakala(val) {
    ayodhanakala = val;
    notifyListeners();
  }

  setfacebook(val) {
    facebook = val;
    notifyListeners();
  }

  setWriter(val) {
    writer = val;
    notifyListeners();
  }

  setinstagram(val) {
    instagram = val;
    notifyListeners();
  }

  setigactive(val) {
    igactive = val;
    notifyListeners();
  }

  settwitter(val) {
    twitter = val;
    notifyListeners();
  }

  settwitteractive(val) {
    twitteractive = val;
    notifyListeners();
  }

  setpublicspeech(val) {
    publicspeech = val;
    notifyListeners();
  }

  setstudyclass(val) {
    studyclass = val;
    notifyListeners();
  }

  setpoemstory(val) {
    poemstory = val;
    notifyListeners();
  }

  setslogan(val) {
    slogan = val;
    notifyListeners();
  }

  setservice(val) {
    service = val;
    notifyListeners();
  }

  setcounselling(val) {
    counselling = val;
    notifyListeners();
  }

  setpublicrelation(val) {
    publicrelation = val;
    notifyListeners();
  }

  setopportunityfinder(val) {
    opportunityfinder = val;
    notifyListeners();
  }

  setorganize(val) {
    organize = val;
    notifyListeners();
  }

  setteamwork(val) {
    teamwork = val;
    notifyListeners();
  }

  setmotivation(val) {
    motivation = val;
    notifyListeners();
  }

  submit({
    required stateDropDownValue,
    required districtDropdownValue,
    required constituencyDropdownValue,
    required panchayathDropdownValue,
    required wardDropdownValue,
    required unitDropdownValue,
    String? id,
  }) async {
    var data = {
      'id': id ?? '',
      'bearerTypeDropdownValue': bearerTypeDropdownValue,
      'selectedMember': selectedMemberdrpodownValue,
      'designationDropDownValue': designationDropDownValue,
      'stateDropDownValue': stateDropDownValue,
      'districtDropdownValue': districtDropdownValue,
      'constituencyDropdownValue': constituencyDropdownValue,
      'panchayathDropdownValue': panchayathDropdownValue,
      'wardDropdownValue': wardDropdownValue,
      'unitDropdownValue': unitDropdownValue,
      'selectedMembers': selectedMembers,
      'selectedInterestedAreas': selectedInterestedAreas,
      'otherInterestedArea': otherInterestedArea,
      'selectedLanguages': selectedLanguages,
      'otherLanguage': otherLanguage,
      'selectedEducationalQualification': selectedEducationalQualification,
      'selectedJob': selectedJob,
      'otherJob': otherJob,
      'ayodhanakala': ayodhanakala,
      'facebook': facebook,
      'writer': writer,
      'instagram': instagram,
      'igactive': igactive,
      'twitter': twitter,
      'twitteractive': twitteractive,
      'publicspeech': publicspeech,
      'studyclass': studyclass,
      'poemstory': poemstory,
      'slogan': slogan,
      'service': service,
      'counselling': counselling,
      'publicrelation': publicrelation,
      'opportunityfinder': opportunityfinder,
      'organize': organize,
      'teamwork': teamwork,
      'motivation': motivation,
      'status': statusDropDown == "Active" ? 1 : 0,
    };

    await createBearerAPI(data);
    getOfficeBearerList();
  }

  getOfficeBearerList({
    String? designation,
    String? stateId,
    String? districtId,
    String? constId,
    String? panchayathId,
    String? wardId,
    String? unitId,
  }) async {
    toggleloading(true);
    var response = await bearerListAPI(
      designation: designation != "Select Designation" ? designation : '',
      stateId: stateId != "Select State" ? stateId : '',
      districtId: districtId != "Select District" ? districtId : '',
      constId: constId != "Select Constituency" ? constId : '',
      panchayathId: panchayathId != "Select Panchayath" ? panchayathId : '',
      wardId: wardId != "Select Ward" ? wardId : '',
      unitId: unitId != "Select Unit" ? unitId : '',
      status: statusDropDown == "Active" ? 1 : 0,
    );

    var responseJson = response.data;

    bearerList = [];
    //jsonloop

    for (var bearerListjson in responseJson['members']) {
      OfficeBearerListModel tempofficeBearerList =
          OfficeBearerListModel.fromJson(bearerListjson);
      bearerList.add(tempofficeBearerList);
    }
    toggleloading(false);
  }
}
