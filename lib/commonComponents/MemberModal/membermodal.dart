import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';
import 'package:wellfare_party_app/commonComponents/myLoader.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/userprovider.dart';
import 'package:wellfare_party_app/utils/extensions.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

import '../../MainConst/main_const.dart';
import '../../Screens/AddMemberScreen/add_member_screen.dart';
import '../../models/member_model.dart';

memberModal(
  context,
  String title,
  String memberType,
  bool show,
) {
  showCupertinoModalBottomSheet(
    elevation: 110,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    builder: (context) => MemberList(
      title: title,
      show: show,
      memberType: memberType,
    ),
  ).whenComplete(() {
    Provider.of<MemberProvder>(context, listen: false)
        .getMembers(memberType: "Member");
    Provider.of<MemberProvder>(context, listen: false)
        .getMembers(memberType: "Primary Member");
  });
}

class MemberList extends StatefulWidget {
  String title;
  bool show;
  String memberType;

  MemberList({
    required this.title,
    required this.show,
    required this.memberType,
    Key? key,
  }) : super(key: key);

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  String certificateURL = "$baseUrl/api/Members/membership_certificate/";

  void _downloadPdf() async {
    final Uri _url;

    if (widget.memberType == "member") {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvder>(
      builder: (context, memberprovider, child) => SizedBox(
        height: MediaQuery.of(context).size.height / 1.2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Container(
                  height: 40, child: Image.asset("assets/icons/pdf.png")),
              onPressed: () {
                _downloadPdf();
              }),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            color: textGreenColor,
                          ),
                        ),
                        if (Provider.of<UserProvider>(context, listen: false)
                                    .role ==
                                unitPresident &&
                            widget.show == false)
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AddMemberScreen.id);
                            },
                            child: Container(
                              width: 140,
                              height: 35,
                              decoration: BoxDecoration(
                                color: primaryRed,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      color: Colors.grey.shade200),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "+ Add Primary Member",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        // if (widget.title == "Members")
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showfilter = !showfilter;
                            });
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/icons/filter.png"),
                          ),
                        ),
                      ],
                    ),
                    if (showfilter == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FilterButton(
                                isSelected:
                                    selectedButton == "all" ? true : false,
                                title: "All",
                                onpress: () {
                                  setState(() {
                                    selectedButton = "all";
                                  });

                                  if (widget.memberType == "member") {
                                    memberprovider.getMembers(
                                        memberType: "Member");
                                  } else {
                                    memberprovider.getMembers(
                                        memberType: "Primary Member");
                                  }
                                },
                              ),
                              FilterButton(
                                isSelected:
                                    selectedButton == "male" ? true : false,
                                title: "Male",
                                onpress: () {
                                  setState(() {
                                    selectedButton = "male";
                                  });
                                  if (widget.memberType == "member") {
                                    memberprovider.getMembers(
                                      gender: "Male",
                                      memberType: "Member",
                                    );
                                  } else {
                                    memberprovider.getMembers(
                                      gender: "Male",
                                      memberType: "Primary Member",
                                    );
                                  }
                                },
                              ),
                              FilterButton(
                                isSelected:
                                    selectedButton == "female" ? true : false,
                                title: "Female",
                                onpress: () {
                                  setState(() {
                                    selectedButton = "female";
                                  });
                                  if (widget.memberType == "member") {
                                    memberprovider.getMembers(
                                      gender: "Female",
                                      memberType: "Member",
                                    );
                                  } else {
                                    memberprovider.getMembers(
                                        gender: "Female",
                                        memberType: "Primary Member");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: memberprovider.loading == true
                    ? MyLoader()
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          if ((widget.memberType == "members" &&
                                  memberprovider.members.isEmpty) ||
                              (widget.memberType == "primarymembers" &&
                                  memberprovider.primaryMembers.isEmpty))
                            const Center(
                              child: Text("No members"),
                            ),
                          for (var member in widget.memberType == "members"
                              ? memberprovider.members
                              : memberprovider.primaryMembers)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: primaryRed.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => AddMemberScreen(
                                          edit: true,
                                          member: member,
                                          show: widget.show,
                                        ),
                                      ),
                                    );
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    children: [
                                      Text(
                                        member.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (widget.show == false)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (builder) =>
                                                      AddMemberScreen(
                                                    edit: true,
                                                    member: member,
                                                    show: widget.show,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.edit_outlined,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      if (member.regNo != null)
                                        Text(member.regNo.toString()),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Text(
                                      //   member.status == "0" ? "Inactive" : "Active",
                                      //   style: TextStyle(
                                      //     color: member.status == "0"
                                      //         ? primaryRed
                                      //         : primaryGreen,
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                      Text(member.gender),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Mob : ${member.mobile}"),
                                    ],
                                  ),
                                  trailing: widget.show == false
                                      ? ElevatedButton(
                                          onPressed: () {
                                            _downloadCertificate(
                                                certificateURL + member.id);
                                          },
                                          child: Text("Certificate"),
                                          style: ElevatedButton.styleFrom(
                                              primary: primaryGreen),
                                        )
                                      : const Icon(
                                          Icons.arrow_forward_ios,
                                          color: primaryGreen,
                                        ),
                                ),
                              ),
                            )
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  String title;
  Function() onpress;
  bool? isSelected = true;
  FilterButton({
    required this.title,
    required this.onpress,
    this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected == true ? primaryRed : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: primaryRed),
          boxShadow: [
            BoxShadow(
                blurRadius: 2, spreadRadius: 2, color: Colors.grey.shade200)
          ],
        ),
        height: 30,
        width: 80,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: isSelected == true ? Colors.white : primaryGreyColor),
          ),
        ),
      ),
    );
  }
}
