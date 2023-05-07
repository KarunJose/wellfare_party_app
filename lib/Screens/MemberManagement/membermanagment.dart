import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/AddMemberScreen/add_member_screen.dart';
import 'package:wellfare_party_app/Screens/MemberManagement/member_card.dart';
import 'package:wellfare_party_app/commonComponents/HeirarchyFilttering/heirarchyfiltering.dart';
import 'package:wellfare_party_app/models/member_model.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/userprovider.dart';
import 'package:wellfare_party_app/utils/extensions.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

import '../../commonComponents/wave_loader.dart';

class MemberManagementScreen extends StatefulWidget {
  static const String id = "membermanagement";
  // String title;
  // bool show;

  MemberManagementScreen(
      {
      //  required this.title,
      // required this.show,

      Key? key})
      : super(key: key);

  @override
  State<MemberManagementScreen> createState() => _MemberManagementScreenState();
}

class _MemberManagementScreenState extends State<MemberManagementScreen> {
  String memberType = "";
  filtter() {
    var membprov = Provider.of<MemberProvder>(context, listen: false);
    var hierarchypov = Provider.of<HeirarchyProvider>(context, listen: false);
    String name = "", phone = "";

    if (memberType == "primarymember" &&
        membprov.memberDropdownValue != "Select Member") {
      Member member = membprov.primaryMembers.firstWhere(
          (element) => element.id == membprov.memberDropdownValue.id);
      name = member.name;
    } else if (memberType == "member" &&
        membprov.memberDropdownValue != "Select Member") {
      Member member = membprov.members.firstWhere((element) {
        return element.id == membprov.memberDropdownValue.id;
      });
      name = member.name;
    }

    membprov.getMembers(
      memberType: memberType,
      districtId: hierarchypov.districtDropdownValue,
      constId: hierarchypov.constituencyDropdownValue,
      panchayathId: hierarchypov.panchayathDropdownValue,
      wardId: hierarchypov.wardDropdownValue,
      unitId: hierarchypov.unitDropdownValue,
      name: name,
      phone: mobileController.text,
      status: membprov.statusDropDown,
      gender: membprov.genderDropdownValue,
    );
  }

  TextEditingController mobileController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    var membprov = Provider.of<MemberProvder>(context, listen: false);

    await membprov.resetData();
  }

  String certificateURL = "$baseUrl/api/Members/membership_certificate/";

  void _downloadPdf() async {
    final Uri _url;

    if (memberType == "member") {
      // Member
      _url = Uri.parse(
          '$baseUrl/api/Members/membership_report?user_id=3&member_type=Member&gender=${selectedButton.capitalize()}');
    } else {
      // Primary
      _url = Uri.parse(
          '$baseUrl/api/Members/membership_report?user_id=3&member_type=Member&gender=${selectedButton.capitalize()}');
    }

    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      showSnackbar(
        context: context,
        text: "Failed",
      );
    }
  }

  void _downloadCertificate(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      showSnackbar(
        context: context,
        text: "Failed",
      );
    }
  }

  bool showfilter = false;
  bool isSelectd = false;
  String selectedButton = "all";

  bool filterclicked = false;

  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 16),
          ),
        );
    return WillPopScope(
      onWillPop: () async {
        var memberpov = Provider.of<MemberProvder>(context, listen: false);
        memberpov.getMemberCount();
        return true;
      },
      child: Scaffold(
        floatingActionButton: Container(
          height: 40.0,
          width: 100.0,
          child: FittedBox(
            child: Row(
              children: [
                FloatingActionButton(
                  child: Container(
                    height: 30,
                    child: Image.asset("assets/icons/pdf.png"),
                  ),
                  heroTag: null,
                  onPressed: () {
                    _downloadPdf();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                // if (Provider.of<UserProvider>(context, listen: false).role ==
                //         unitPresident &&
                //     widget.show == false)
                FloatingActionButton(
                  backgroundColor: textGreenColor,
                  child: const Icon(Icons.add),
                  heroTag: null,
                  onPressed: () {
                    Navigator.pushNamed(context, AddMemberScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Member Management",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  var hierarchypov =
                      Provider.of<HeirarchyProvider>(context, listen: false);
                  hierarchypov.resetData();
                  var memberpov =
                      Provider.of<MemberProvder>(context, listen: false);
                  memberpov.resetData();
                },
                icon: Icon(Icons.sync)),
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer2<MemberProvder, HeirarchyProvider>(
            builder: (context, memberProvider, hierarchyProvider, child) =>
                Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 70, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeirarchyFilttering(
                        showTitle: false,
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      //   child: Text(
                      //     "Select Member Type",
                      //     style: TextStyle(fontSize: 16, color: Colors.grey),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: borderGrayColor,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // child: Text("dd"),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<String>(
                                dropdownColor: const Color(0xFFFFFFFF),
                                value: memberProvider.memberTypeDropDown,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                elevation: 16,
                                style: const TextStyle(
                                    color: primaryGreyColor,
                                    fontWeight: FontWeight.w500),
                                onChanged: (String? newValue) {
                                  memberProvider.selectMemberType(newValue);
                                  memberProvider.selectMember('Select Member');

                                  if (newValue == "Primary Member") {
                                    setState(() {
                                      memberType = "primarymember";
                                    });
                                  } else if (newValue == "Member") {
                                    setState(() {
                                      memberType = "member";
                                    });
                                  }

                                  filtter();
                                },
                                items: memberProvider.memberType
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: borderGrayColor,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // child: Text("dd"),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<String>(
                                dropdownColor: const Color(0xFFFFFFFF),
                                value: memberProvider.genderDropdownValue,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                elevation: 16,
                                style: const TextStyle(
                                    color: primaryGreyColor,
                                    fontWeight: FontWeight.w500),
                                onChanged: (String? newValue) {
                                  memberProvider.selectGenderType(newValue);
                                },
                                items: memberProvider.gender
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: borderGrayColor,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // child: Text("dd"),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<dynamic>(
                                dropdownColor: const Color(0xFFFFFFFF),
                                value: memberProvider.memberDropdownValue,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                elevation: 16,
                                style: const TextStyle(
                                    color: primaryGreyColor,
                                    fontWeight: FontWeight.w500),
                                onChanged: (dynamic newValue) {
                                  if (newValue != 'Select Member') {
                                    memberProvider.selectMember(newValue);
                                  } else {
                                    // Show select a member snackbar
                                  }
                                },
                                items: [
                                  'Select Member',
                                  if (memberType == "primarymember")
                                    ...memberProvider.primaryMembers
                                  else if (memberType == "member")
                                    ...memberProvider.members
                                  else
                                    ...[]
                                ].map<DropdownMenuItem<dynamic>>(
                                    (dynamic value) {
                                  if (value is String) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  } else {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  }
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 20, vertical: 5),
                      //   child: Container(
                      //     height: 50,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       boxShadow: [
                      //         BoxShadow(
                      //             blurRadius: 6,
                      //             spreadRadius: 2,
                      //             color: Colors.grey.shade200),
                      //       ],
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     // child: Text("dd"),
                      //     child: DropdownButtonHideUnderline(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 10),
                      //         child: DropdownButton<dynamic>(
                      //           dropdownColor: const Color(0xFFFFFFFF),
                      //           value: memberProvider.memberDropdownValue ==
                      //                   'Select Member'
                      //               ? 'Select Mobile'
                      //               : memberProvider.memberDropdownValue,
                      //           icon: const Icon(Icons.arrow_drop_down_sharp),
                      //           elevation: 16,
                      //           style: const TextStyle(
                      //               color: primaryGreyColor,
                      //               fontWeight: FontWeight.w500),
                      //           onChanged: (dynamic newValue) {
                      //             if (newValue != 'Select Mobile') {
                      //               memberProvider.selectMember(newValue);
                      //             }
                      //           },
                      //           items: [
                      //             'Select Mobile',
                      //             if (memberType == "primarymember")
                      //               ...memberProvider.primaryMembers
                      //             else if (memberType == "member")
                      //               ...memberProvider.members
                      //             else
                      //               ...[]
                      //           ].map<DropdownMenuItem<dynamic>>((dynamic value) {
                      //             if (value is String) {
                      //               return DropdownMenuItem<dynamic>(
                      //                 value: value,
                      //                 child: Text(value),
                      //               );
                      //             } else {
                      //               return DropdownMenuItem<dynamic>(
                      //                 value: value,
                      //                 child: Text(value.mobile),
                      //               );
                      //             }
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      AddMemberTextField(
                        // formValidator: (dynamic value) {
                        //   if (value.isEmpty || value.length != 10) {
                        //     return 'invalid number';
                        //   }
                        // },
                        hint: "Mobile",
                        width: double.infinity,
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        limit: 10,
                        // enabled: !widget.show,
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      //   child: Text(
                      //     "Status",
                      //     style: TextStyle(fontSize: 16, color: Colors.grey),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: borderGrayColor,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // child: Text("dd"),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<String>(
                                dropdownColor: const Color(0xFFFFFFFF),
                                value: memberProvider.statusDropDown,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                elevation: 16,
                                style: const TextStyle(
                                    color: primaryGreyColor,
                                    fontWeight: FontWeight.w500),
                                onChanged: (String? newValue) {
                                  memberProvider.selectStatus(newValue);
                                },
                                items: memberProvider.status
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

                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(120, 35)),
                            onPressed: () {
                              if (memberProvider.memberTypeDropDown ==
                                  "Select Member Type") {
                                showSnackbar(
                                    context: context,
                                    text: "Please Select Member Type");
                              }
                              filtter();
                              setState(() {
                                filterclicked = true;
                              });
                            },
                            child: const Text(
                              "Show",
                              style:
                                  TextStyle(fontSize: 16, letterSpacing: 0.5),
                            )),
                      ),
                      // Text(memberProvider.members.length.toString()),
                      // Text(memberProvider.primaryMembers.length.toString()),
                      if (filterclicked == true &&
                          memberProvider.loading == false)
                        for (var member in memberType == "member"
                            ? memberProvider.members
                            : memberType == "primarymember"
                                ? memberProvider.primaryMembers
                                : [])
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => AddMemberScreen(
                                    edit: true,
                                    member: member,
                                  ),
                                ),
                              );
                            },
                            child: MemberCard(
                              member: member,
                              show: memberType == "member",
                            ),
                          ),
                    ],
                  ),
                ),
                if (memberProvider.loading == true ||
                    hierarchyProvider.loading == true)
                  const WaveLoader()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
