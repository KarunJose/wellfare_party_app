import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/AddOfficeBearerScreen/add_office_bearer_toggle_screen.dart';
import 'package:wellfare_party_app/commonComponents/HeirarchyFilttering/heirarchyfiltering.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/designation_model.dart';
import 'package:wellfare_party_app/models/officebearer_list_model.dart';
import 'package:wellfare_party_app/providers/bearer_provider.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/report_provider.dart';

import '../AddMemberScreen/add_member_screen.dart';

class AddOfficeBearer extends StatefulWidget {
  static const String id = "addofficebearer";
  bool edit;
  OfficeBearerListModel? bearer;
  AddOfficeBearer({
    Key? key,
    this.edit = false,
    this.bearer,
  }) : super(key: key);

  @override
  State<AddOfficeBearer> createState() => _AddOfficeBearerState();
}

class _AddOfficeBearerState extends State<AddOfficeBearer> {
  final TextEditingController _jobOtherController = TextEditingController();
  final TextEditingController _interestedAreaOtherController =
      TextEditingController();
  final TextEditingController _languageOtherController =
      TextEditingController();

  String userType = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    var reportPov = Provider.of<ReportProvider>(context, listen: false);
    var bearerPov = Provider.of<BearerProvider>(context, listen: false);
    var memberPov = Provider.of<MemberProvder>(context, listen: false);
    await bearerPov.resetdata();

    await memberPov.getMembers(memberType: "Member");

    await reportPov.getDesignation();
    await reportPov.getSubcommittee();

    final prefs = await SharedPreferences.getInstance();
    final user_type = prefs.getString('user_type');
    final master_id = prefs.getString('master_id');

    setState(() {
      userType = user_type.toString();
    });

    if (widget.edit == true) {
      await bearerPov
          .selectStatus(widget.bearer!.status == "1" ? "Active" : "Inactive");
      bearerPov.setselectedBearerType(widget.bearer!.bearerType);
      bearerPov.setselectedEducationalQualification(
          widget.bearer!.educationQualification);
      bearerPov.setdesignationDropDownValue(widget.bearer!.designationId);
      bearerPov.setselectedMember(widget.bearer!.memberId);

      bearerPov.setselectedJob(widget.bearer!.job);
      bearerPov.setOtherJob(widget.bearer!.otherJob);
      for (var intrestedArea in widget.bearer!.interestedArea) {
        bearerPov.addToSelectedInterestedAreas(intrestedArea);
      }
      for (var languages in widget.bearer!.languages) {
        bearerPov.addToSelectedLanguage(languages);
      }
      bearerPov.setayodhanakala(widget.bearer!.martialArts);
      bearerPov.setfacebook(widget.bearer!.facebook);
      bearerPov.setWriter(widget.bearer!.selfWrite);
      bearerPov.setinstagram(widget.bearer!.instagram);
      bearerPov.setigactive(widget.bearer!.instagramActive);
      bearerPov.settwitter(widget.bearer!.twitter);
      bearerPov.settwitteractive(widget.bearer!.twitterActive);
      bearerPov.setpublicspeech(widget.bearer!.speech);
      bearerPov.setstudyclass(widget.bearer!.studyClass);
      bearerPov.setpoemstory(widget.bearer!.writePoemStory);
      bearerPov.setslogan(widget.bearer!.slogan);
      bearerPov.setservice(widget.bearer!.serviceAttitude);
      bearerPov.setcounselling(widget.bearer!.councelling);
      bearerPov.setpublicrelation(widget.bearer!.personalRelationship);
      bearerPov.setopportunityfinder(widget.bearer!.newChances);
      bearerPov.setteamwork(widget.bearer!.teamWork);
      bearerPov.setmotivation(widget.bearer!.inspireTeammates);
      bearerPov.setorganize(widget.bearer!.organization);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<BearerProvider>(context, listen: false).resetdata();
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Add Office Bearer",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            body: Consumer4<ReportProvider, BearerProvider, MemberProvder,
                HeirarchyProvider>(
              builder: (context, reportProvider, bearerProvider, memberProvider,
                      hirarchyProvider, child) =>
                  WillPopScope(
                onWillPop: () async {
                  var hierarchyPov =
                      Provider.of<HeirarchyProvider>(context, listen: false);

                  var membpov =
                      Provider.of<MemberProvder>(context, listen: false);

                  hierarchyPov.setInitialData(
                      all: true, edit: false, context: context, entity: null);
                  membpov.resetData();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeirarchyFilttering(
                              edit: widget.edit, entity: widget.bearer),

                          //Designation

                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              "Designation",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),

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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    dropdownColor: const Color(0xFFFFFFFF),
                                    value:
                                        bearerProvider.designationDropDownValue,
                                    icon:
                                        const Icon(Icons.arrow_drop_down_sharp),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: primaryGreyColor,
                                        fontWeight: FontWeight.w500),
                                    onChanged: (String? newValue) {
                                      bearerProvider
                                          .setdesignationDropDownValue(
                                              newValue!);
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
                          bearerProvider.designationInvalid == true
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "*Designation requierd",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                          // members
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              widget.edit == true ? "Member" : "Members",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          widget.edit == true
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(widget.bearer!.memberName),
                                )
                              : Padding(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: DropdownButton<String>(
                                          dropdownColor:
                                              const Color(0xFFFFFFFF),
                                          value: bearerProvider
                                              .selectedMemberdrpodownValue,
                                          icon: const Icon(
                                              Icons.arrow_drop_down_sharp),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: primaryGreyColor,
                                              fontWeight: FontWeight.w500),
                                          onChanged: (String? newValue) {
                                            bearerProvider
                                                .setselectedMember(newValue!);
                                          },
                                          items: [
                                            "Select Member",
                                            ...memberProvider.members
                                          ].map<DropdownMenuItem<String>>(
                                              (dynamic value) {
                                            if (value == "Select Member") {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }
                                            return DropdownMenuItem<String>(
                                              value: value.id,
                                              child: Text(value.name),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          bearerProvider.selectMemberInvalid == true
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "*Select Member",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                          //education qualification

                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              "വിദ്യാഭ്യാസ യോഗ്യത",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),

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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    dropdownColor: const Color(0xFFFFFFFF),
                                    value: bearerProvider
                                        .selectedEducationalQualification,
                                    icon:
                                        const Icon(Icons.arrow_drop_down_sharp),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: primaryGreyColor,
                                        fontWeight: FontWeight.w500),
                                    onChanged: (String? newValue) {
                                      bearerProvider
                                          .setselectedEducationalQualification(
                                              newValue!);
                                    },
                                    items: bearerProvider
                                        .educationalQualification
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          bearerProvider.educationalQualificationInvalid == true
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "*Select Educational Qualification",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                          //job
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              "തൊഴില്‍",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),

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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    dropdownColor: const Color(0xFFFFFFFF),
                                    value: bearerProvider.selectedJob,
                                    icon:
                                        const Icon(Icons.arrow_drop_down_sharp),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: primaryGreyColor,
                                        fontWeight: FontWeight.w500),
                                    onChanged: (String? newValue) {
                                      bearerProvider.setselectedJob(newValue!);
                                    },
                                    items: bearerProvider.jobs
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          bearerProvider.jobInvalid == true
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "*Select Job",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                          if (bearerProvider.selectedJob == "Other")
                            AddMemberTextField(
                              hint: "Other Job",
                              width: double.infinity,
                              controller: _jobOtherController,
                              onChanged: (val) {
                                bearerProvider.setOtherJob(val!);
                              },
                            ),

                          //viknjapana mekhala
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              "താല്‍പര്യമുള്ള വൈജ്ഞാനിക മേഖല",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),

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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    dropdownColor: const Color(0xFFFFFFFF),
                                    value: bearerProvider.interestedAreas[0],
                                    icon:
                                        const Icon(Icons.arrow_drop_down_sharp),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: primaryGreyColor,
                                        fontWeight: FontWeight.w500),
                                    onChanged: (String? newValue) {
                                      bearerProvider
                                          .addToSelectedInterestedAreas(
                                              newValue!);
                                    },
                                    items: bearerProvider.interestedAreas
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          bearerProvider.selectedIntrestedAreaInvalid == true
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "*Select Intrested Area",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                          Center(
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                for (String intArea
                                    in bearerProvider.selectedInterestedAreas)
                                  GestureDetector(
                                    onTap: () {
                                      bearerProvider
                                          .removeFromSelectedInterestedAreas(
                                              intArea);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Chip(
                                        padding: const EdgeInsets.all(8),
                                        backgroundColor:
                                            Colors.greenAccent[100],
                                        label: Text(
                                          intArea,
                                          style: const TextStyle(fontSize: 15),
                                        ), //Text
                                        deleteIcon: const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        onDeleted: () {
                                          bearerProvider
                                              .removeFromSelectedInterestedAreas(
                                                  intArea);
                                        },
                                      ),
                                    ),
                                  ), //Chip
                              ],
                            ),
                          ),

                          if (bearerProvider.selectedInterestedAreas
                              .contains("Other"))
                            AddMemberTextField(
                              hint: "Other Interested Area",
                              width: double.infinity,
                              controller: _interestedAreaOtherController,
                              onChanged: (val) {
                                bearerProvider.setOtherInterestedAreas(val!);
                              },
                            ),

                          //Languages
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              "ഭാഷകള്",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),

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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    dropdownColor: const Color(0xFFFFFFFF),
                                    value: bearerProvider.languages[0],
                                    icon:
                                        const Icon(Icons.arrow_drop_down_sharp),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: primaryGreyColor,
                                        fontWeight: FontWeight.w500),
                                    onChanged: (String? newValue) {
                                      bearerProvider
                                          .addToSelectedLanguage(newValue!);
                                    },
                                    items: bearerProvider.languages
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          bearerProvider.languageInvalid == true
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "*Select Language",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                          if (bearerProvider.selectedLanguages
                              .contains("Other"))
                            AddMemberTextField(
                              hint: "Other Language",
                              width: double.infinity,
                              controller: _languageOtherController,
                              onChanged: (val) {
                                bearerProvider.setOtherLanguage(val!);
                              },
                            ),

                          Center(
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                for (String language
                                    in bearerProvider.selectedLanguages)
                                  GestureDetector(
                                    onTap: () {
                                      bearerProvider
                                          .removeFromSelectedLanguage(language);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Chip(
                                        padding: const EdgeInsets.all(8),
                                        backgroundColor:
                                            Colors.greenAccent[100],
                                        label: Text(
                                          language,
                                          style: const TextStyle(fontSize: 15),
                                        ), //Text
                                        deleteIcon: const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        onDeleted: () {
                                          bearerProvider
                                              .removeFromSelectedLanguage(
                                                  language);
                                        },
                                      ),
                                    ),
                                  ), //Chip
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                bool error = false;
                                error = hirarchyProvider.checkDta() || error;
                                error =
                                    bearerProvider.checkdesignation() || error;
                                error = bearerProvider.checkIntrestedArea() ||
                                    error;

                                if (widget.edit == false) {
                                  error = bearerProvider.checkMember() || error;
                                }

                                error = bearerProvider
                                        .checkEducationalQualification() ||
                                    error;

                                error = bearerProvider.checkJob() || error;
                                if (error == true) {
                                  return;
                                }
                                // Navigator.pushNamed(context,
                                //     AddofficebearerToggleQuestionScreen.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) =>
                                        AddofficebearerToggleQuestionScreen(
                                      bearer: widget.bearer,
                                    ),
                                  ),
                                );
                              },
                              child: Text("Next"),
                              style: ElevatedButton.styleFrom(
                                  primary: primaryGreen,
                                  fixedSize: Size(150, 40)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      if (reportProvider.loading == true ||
                          bearerProvider.loading == true ||
                          hirarchyProvider.loading == true)
                        const WaveLoader(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
