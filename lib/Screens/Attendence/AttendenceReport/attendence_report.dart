import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/Attendence/attendence.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/attendence_model.dart';
import 'package:wellfare_party_app/providers/attendence_Provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

class AttendenceReport extends StatefulWidget {
  static const String id = "attendencereport";
  AttendenceReport({Key? key}) : super(key: key);

  @override
  State<AttendenceReport> createState() => _AttendenceReportState();
}

class _AttendenceReportState extends State<AttendenceReport> {
  String? fromdate;
  String? todate;

  void _downloadPdf() {}

  @override
  Widget build(BuildContext context) {
    return Consumer2<AttendenceProvider, MemberProvder>(
      builder: (context, attendenceProvider, memberProvider, child) =>
          WillPopScope(
        onWillPop: () async {
          attendenceProvider.clearData();
          return true;
        },
        child: Scaffold(
          floatingActionButton: Container(
            height: 45,
            child: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: textGreenColor,
                onPressed: () {
                  Navigator.pushNamed(context, Attendence.id);
                }),
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              "Attendence Report",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  _downloadPdf();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.print_outlined),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          const Text(
                            "From",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff515151),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
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
                                  fromdate = newFormat.format(convertLocal);
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
                                  fromdate == null ? "Select Date" : fromdate!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          const Text(
                            "To",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff515151),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
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
                                  todate = newFormat.format(convertLocal);
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
                                  todate == null ? "Select Date" : todate!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (attendenceProvider.loading == true) {
                          WaveLoader();
                        }
                        if (fromdate == null) {
                          showSnackbar(
                              context: context, text: "Select start date");
                          return;
                        } else if (todate == null) {
                          showSnackbar(
                              context: context, text: "Select end date");
                          return;
                        }
                        attendenceProvider.getAttendenceDetails(
                            fromDate: fromdate, toDate: todate);
                      },
                      child: const Icon(
                        Icons.search_outlined,
                      ),
                    )
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
                  child: attendenceProvider.attendenceList.isEmpty
                      ? const Center(
                          child: Text(
                          "Select 'from' and 'to' date",
                          style: TextStyle(fontSize: 16),
                        ))
                      : ListView(
                          children: [
                            if (attendenceProvider.attendenceList.isNotEmpty)
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
                            for (AttendenceModel attendence
                                in attendenceProvider.attendenceList)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.9,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            attendence.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        // const Text(
                                        //   "Member",
                                        //   style: TextStyle(fontWeight: FontWeight.w300),
                                        // ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            child: Center(
                                                child: Text(
                                                    attendence.presentCount)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: Center(
                                                child: Text(
                                                    attendence.absendCount)),
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: Center(
                                                child: Text(
                                                    attendence.leaveCount)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
