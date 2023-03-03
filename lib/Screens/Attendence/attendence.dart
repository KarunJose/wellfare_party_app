import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/member_model.dart';
import 'package:wellfare_party_app/providers/attendence_Provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

import 'components/singleMemberAttendenceCard.dart';

class Attendence extends StatefulWidget {
  static const String id = "attendence";
  const Attendence({super.key});

  @override
  State<Attendence> createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  Map<String, String> attendenceDetails = {};
  String? selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() {
    var memberPov = Provider.of<MemberProvder>(context, listen: false);
    memberPov.getMembers(memberType: "member");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MemberProvder, AttendenceProvider>(
      builder: (context, memberProvider, attendenceProvider, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Attendence",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                if (selectedDate == null) {
                  showSnackbar(context: context, text: "Select meeting date");
                  return;
                }
                await attendenceProvider.addAttendence(
                  meetingDate: selectedDate,
                  memberId: attendenceDetails.keys.toList(),
                  status: attendenceDetails.values.toList(),
                );
                showSnackbar(
                    context: context, text: "Attendence added Successfully");
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.save_outlined),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Meeting Date",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff515151),
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            DateTime now = DateTime.now();
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: now,
                            );
                            setState(() {
                              if (date != null) {
                                var strToDateTime =
                                    DateTime.parse(date.toString());
                                final convertLocal = strToDateTime.toLocal();
                                var newFormat = DateFormat("dd-MM-yyyy");
                                selectedDate = newFormat.format(convertLocal);
                              }
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                                color: textGreenColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                selectedDate == null
                                    ? "Select Date"
                                    : selectedDate!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Color(0xffDFFFED),
                    ),
                    width: double.infinity,
                    child: memberProvider.loading == true
                        ? WaveLoader()
                        : ListView(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AttendenceTitle(
                                        title: "Present",
                                        color: textGreenColor),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AttendenceTitle(
                                      title: "Absent",
                                      color: const Color(0XFFEE9A1D),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AttendenceTitle(
                                      title: "Leave",
                                      color: const Color(0xffDA251C),
                                    ),
                                  ],
                                ),
                              ),
                              for (Member members in memberProvider.members)
                                SingleMemberAttendenceCard(
                                  member: members,
                                  selectedAttendenceValue:
                                      (Member member, String attendence) {
                                    setState(() {
                                      attendenceDetails[member.id] = attendence;
                                    });
                                  },
                                )
                            ],
                          ),
                  ),
                ),
              ],
            ),
            if (attendenceProvider.loading == true) WaveLoader()
          ],
        ),
      ),
    );
  }
}

class AttendenceTitle extends StatelessWidget {
  String title;
  Color color;
  AttendenceTitle({
    required this.title,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color,
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
