import 'package:flutter/cupertino.dart';
import 'package:wellfare_party_app/api/attendence_api.dart';
import 'package:wellfare_party_app/models/attendence_model.dart';

class AttendenceProvider extends ChangeNotifier {
  List<AttendenceModel> attendenceList = [];

  bool loading = false;
  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  getAttendenceDetails({
    String? fromDate,
    String? toDate,
  }) async {
    toggleloading(true);
    var response = await getAttendenceReportAPI(
      fromDate: fromDate,
      toDate: toDate,
    );
    var responseJson = response.data;
    for (var attendence in responseJson["members"]) {
      attendenceList.add(AttendenceModel.fromJson(attendence));
    }
    toggleloading(false);
  }

  clearData() {
    attendenceList = [];
  }

  addAttendence({
    String? meetingDate,
    List<String>? memberId,
    List<String>? status,
  }) async {
    toggleloading(true);
    var response = await addAttendenceAPI(
      meetingDate: meetingDate,
      memberId: memberId,
      status: status,
    );
    toggleloading(false);
  }
}
