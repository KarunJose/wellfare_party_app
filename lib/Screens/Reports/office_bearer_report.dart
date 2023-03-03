import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/Reports/report_search_result.dart';
import 'package:wellfare_party_app/models/constituency_model.dart';
import 'package:wellfare_party_app/models/designation_model.dart';
import 'package:wellfare_party_app/models/district_model.dart';
import 'package:wellfare_party_app/models/panchayath_model.dart';
import 'package:wellfare_party_app/models/state_model.dart';
import 'package:wellfare_party_app/models/subcommitee_model.dart';
import 'package:wellfare_party_app/models/unit_model.dart';
import 'package:wellfare_party_app/models/ward_model.dart';
import 'package:wellfare_party_app/providers/report_provider.dart';

class OfficeBearerReport extends StatefulWidget {
  static const String id = "officebearerreport";
  String reporttype;

  OfficeBearerReport({
    Key? key,
    required this.reporttype,
  }) : super(key: key);

  @override
  State<OfficeBearerReport> createState() => _OfficeBearerReportState();
}

class _OfficeBearerReportState extends State<OfficeBearerReport> {
  String subcommitteeDropdownValue = "All";
  String designationDropDownValue = "Select Designation";
  String stateDropDownValue = "All";
  String districtDropdownValue = "All";
  String constituencyDropdownValue = "All";
  String panchayathDropdownValue = "All";
  String wardDropdownValue = "All";
  String unitDropdownValue = "All";

  String userType = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    var reportPov = Provider.of<ReportProvider>(context, listen: false);
    await reportPov.getDesignation();
    await reportPov.getSubcommittee();
    await reportPov.getState();

    final prefs = await SharedPreferences.getInstance();
    final user_type = prefs.getString('user_type');
    final master_id = prefs.getString('master_id');

    setState(() {
      userType = user_type.toString();
    });

    if (user_type == "state") {
      // Set Selected state
      setState(() {
        if (master_id != null) {
          stateDropDownValue = master_id;
        }
      });
      reportPov.getDistrict(master_id);
    } else if (user_type == "district") {
      await reportPov.getDistrict(null);
      for (var distr in reportPov.district) {
        if (distr.districtId == master_id) {
          setState(() {
            districtDropdownValue = distr.districtId;
            stateDropDownValue = distr.stateId;
          });
          reportPov.getConstituency(distr.districtId);
        }
      }
    } else if (user_type == "constituency") {
      await reportPov.getConstituency(null);
      await reportPov.getDistrict(null);
      for (var constituency in reportPov.constituency) {
        if (constituency.id == master_id) {
          setState(() {
            constituencyDropdownValue = constituency.id;
            districtDropdownValue = constituency.districtId;
            stateDropDownValue = constituency.stateId;
          });
        }
        reportPov.getPanchayth(constituency.id);
      }
    } else if (user_type == "panchayath") {
      await reportPov.getPanchayth(null);
      await reportPov.getConstituency(null);
      await reportPov.getDistrict(null);
      for (var panchayath in reportPov.panchayath) {
        if (panchayath.id == master_id) {
          setState(() {
            panchayathDropdownValue = panchayath.id;
            constituencyDropdownValue = panchayath.constituency;
            districtDropdownValue = panchayath.districtId;
            stateDropDownValue = panchayath.stateId;
          });
          reportPov.getWard(panchayath.id);
        }
      }
    } else if (user_type == "ward") {
      await reportPov.getWard(null);
      await reportPov.getPanchayth(null);
      await reportPov.getConstituency(null);
      await reportPov.getDistrict(null);
      for (var ward in reportPov.ward) {
        if (ward.id == master_id) {
          setState(() {
            wardDropdownValue = ward.id;
            panchayathDropdownValue = ward.panchayathId;
            constituencyDropdownValue = ward.constituencyId;
            districtDropdownValue = ward.districtId;
            stateDropDownValue = ward.stateId;
          });
          reportPov.getUnit(ward.id);
        }
      }
    } else if (user_type == "unit") {
      await reportPov.getUnit(null);
      await reportPov.getWard(null);
      await reportPov.getPanchayth(null);
      await reportPov.getConstituency(null);
      await reportPov.getDistrict(null);
      for (var unit in reportPov.unit) {
        if (unit.id == master_id) {
          setState(() {
            unitDropdownValue = unit.id;
            wardDropdownValue = unit.wardId;
            panchayathDropdownValue = unit.panchayathId;
            constituencyDropdownValue = unit.constituencyId;
            districtDropdownValue = unit.districtId;
            stateDropDownValue = unit.stateId;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: primaryGreen),
        title: Text(
          widget.reporttype == 'bearer'
              ? "Bearer report"
              : "Bearer subcommittee report",
          style: TextStyle(color: primaryGreen, fontSize: 16),
        ),
      ),
      body: Consumer<ReportProvider>(
        builder: (context, reportProvider, child) => SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  //Subcommittee
                  if (widget.reporttype == 'subcommittee')
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        "Subcommitte",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  if (widget.reporttype == 'subcommittee')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                spreadRadius: 2,
                                color: Colors.grey.shade200),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              dropdownColor: const Color(0xFFFFFFFF),
                              value: subcommitteeDropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                setState(() {
                                  subcommitteeDropdownValue = newValue!;
                                });
                              },
                              items: reportProvider.subcommittee
                                  .map<DropdownMenuItem<String>>(
                                      (SubCommitteeModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(value.subCommitteeName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(
                    height: 10,
                  ),

                  //Designation

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Designation",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 6,
                              spreadRadius: 2,
                              color: Colors.grey.shade200),
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // child: Text("dd"),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            dropdownColor: const Color(0xFFFFFFFF),
                            value: designationDropDownValue,
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            elevation: 16,
                            style: const TextStyle(
                                color: primaryGreyColor,
                                fontWeight: FontWeight.w500),
                            onChanged: (String? newValue) {
                              setState(() {
                                designationDropDownValue = newValue!;
                              });
                            },
                            items: reportProvider.designations
                                .map<DropdownMenuItem<String>>(
                                    (Designation value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(value.designationName),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //state
                  if (userType == "state")
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 5,
                      ),
                      child: Text(
                        "State",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  if (userType == "state")
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 5,
                      ),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                spreadRadius: 2,
                                color: Colors.grey.shade200),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // child: Text("dd"),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              dropdownColor: const Color(0xFFFFFFFF),
                              value: stateDropDownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                reportProvider.getDistrict(newValue!);
                                setState(() {
                                  stateDropDownValue = newValue;
                                });
                              },
                              items: reportProvider.state
                                  .map<DropdownMenuItem<String>>(
                                      (StateModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(value.stateName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                  //district
                  if (userType == "state")
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 5,
                      ),
                      child: Text(
                        "District",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  if (userType == "state")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                spreadRadius: 2,
                                color: Colors.grey.shade200),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // child: Text("dd"),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              dropdownColor: const Color(0xFFFFFFFF),
                              value: districtDropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                reportProvider.getConstituency(newValue!);
                                setState(() {
                                  districtDropdownValue = newValue;
                                });
                              },
                              items: reportProvider.district
                                  .map<DropdownMenuItem<String>>(
                                      (DistrictModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.districtId,
                                  child: Text(value.districtName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                  //constituency
                  if (userType == "state" || userType == "district")
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 5,
                      ),
                      child: Text(
                        "Constituency",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  if (userType == "state" || userType == "district")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                spreadRadius: 2,
                                color: Colors.grey.shade200),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // child: Text("dd"),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              dropdownColor: const Color(0xFFFFFFFF),
                              value: constituencyDropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                reportProvider.getPanchayth(newValue!);
                                setState(() {
                                  constituencyDropdownValue = newValue;
                                });
                              },
                              items: reportProvider.constituency
                                  .map<DropdownMenuItem<String>>(
                                      (ConstituencyModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(value.constituencyName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                  //panchayath

                  if (userType == "state" ||
                      userType == "district" ||
                      userType == "constituency")
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 5,
                      ),
                      child: Text(
                        "Panchayath",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  if (userType == "state" ||
                      userType == "district" ||
                      userType == "constituency")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                spreadRadius: 2,
                                color: Colors.grey.shade200),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // child: Text("dd"),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              dropdownColor: const Color(0xFFFFFFFF),
                              value: panchayathDropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                reportProvider.getWard(newValue!);
                                setState(() {
                                  panchayathDropdownValue = newValue;
                                });
                              },
                              items: reportProvider.panchayath
                                  .map<DropdownMenuItem<String>>(
                                      (PanchayathModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(value.panchayathName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                  //Ward

                  if (userType == "state" ||
                      userType == "district" ||
                      userType == "constituency" ||
                      userType == "panchayath")
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 5,
                      ),
                      child: Text(
                        "Ward",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  if (userType == "state" ||
                      userType == "district" ||
                      userType == "constituency" ||
                      userType == "panchayath")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                spreadRadius: 2,
                                color: Colors.grey.shade200),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              dropdownColor: const Color(0xFFFFFFFF),
                              value: wardDropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                reportProvider.getUnit(newValue!);
                                setState(() {
                                  wardDropdownValue = newValue;
                                });
                              },
                              items: reportProvider.ward
                                  .map<DropdownMenuItem<String>>((Ward value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(value.ward),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                  //unit
                  if (userType == "state" ||
                      userType == "district" ||
                      userType == "constituency" ||
                      userType == "panchayath" ||
                      userType == "ward")
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 5,
                      ),
                      child: Text(
                        "Unit",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  if (userType == "state" ||
                      userType == "district" ||
                      userType == "constituency" ||
                      userType == "panchayath" ||
                      userType == "ward")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                spreadRadius: 2,
                                color: Colors.grey.shade200),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              dropdownColor: const Color(0xFFFFFFFF),
                              value: unitDropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                setState(() {
                                  unitDropdownValue = newValue!;
                                });
                              },
                              items: reportProvider.unit
                                  .map<DropdownMenuItem<String>>(
                                      (UnitModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(value.unitName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.reporttype == "bearer") {
                          reportProvider.getReport(
                              stateDropDownValue,
                              districtDropdownValue,
                              constituencyDropdownValue,
                              panchayathDropdownValue,
                              wardDropdownValue,
                              unitDropdownValue,
                              designationDropDownValue);
                        } else {
                          reportProvider.getSubcommitteeReport(
                              stateDropDownValue,
                              districtDropdownValue,
                              constituencyDropdownValue,
                              panchayathDropdownValue,
                              wardDropdownValue,
                              unitDropdownValue,
                              designationDropDownValue,
                              subcommitteeDropdownValue);
                        }
                        Navigator.pushNamed(context, ReportSearchResult.id);
                      },
                      child: Text("Search"),
                      style: ElevatedButton.styleFrom(
                          primary: primaryGreen, fixedSize: Size(150, 40)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              if (reportProvider.loading == true)
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.7),
                  child: const Center(
                      child: SpinKitWave(
                    color: primaryGreen,
                    size: 20.0,
                  )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
