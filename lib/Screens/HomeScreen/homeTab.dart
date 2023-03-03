// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/components/hierarchSummeryCard.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/components/member_coun_section.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/components/messageSectionCard.dart';
import 'package:wellfare_party_app/Screens/ReportData/add_report_screen.dart';
import 'package:wellfare_party_app/Screens/SubmittedReportList/submitted_report_list.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/hierarchiInfoModel.dart';
import 'package:wellfare_party_app/models/qa_model.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/notificationprovider.dart';
import 'package:wellfare_party_app/providers/questions_provider.dart';
import 'package:wellfare_party_app/providers/rootapp_provider.dart';
import 'package:wellfare_party_app/providers/userprovider.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';
import 'components/notification_horizontal_list.dart';

class HomeTab extends StatefulWidget {
  static const String id = "hometab";
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool edit = false;
  String subtitle = "";

  TextEditingController titleController = TextEditingController();
  // TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    await Provider.of<MemberProvder>(context, listen: false)
        .getMembers(memberType: "Member");
    await Provider.of<MemberProvder>(context, listen: false)
        .getMembers(memberType: "Primary Member");

    await Provider.of<MemberProvder>(context, listen: false).getMemberCount();
    Provider.of<NotificationProvider>(context, listen: false).getNotification();

    await Provider.of<HeirarchyProvider>(context, listen: false)
        .gethierarchyInfo();

    await Provider.of<QuestionsProvider>(context, listen: false)
        .getSubmittedAnswersList();
    await Provider.of<QuestionsProvider>(context, listen: false).getdraftList();
    final prefs = await SharedPreferences.getInstance();

    var title = prefs.getString('title');
    setState(() {
      subtitle = prefs.getString('subtitle') ?? "";
    });

    if (title != null) {
      titleController.text = title;
    }
    // if (subtitle != null) {
    //   subtitleController.text = subtitle;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<MemberProvder, UserProvider, RootAppProvider,
            HeirarchyProvider, QuestionsProvider>(
        builder: (context, memberProvider, userProvider, rootAppProvider,
            hirarchiProvider, questionsProvider, child) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 53,
                            width: 2,
                            color: textGreenColor,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  edit == true
                                      ? TextField(
                                          controller: titleController,
                                          style: const TextStyle(
                                              fontSize: 21,
                                              color: Colors.black),
                                          decoration: const InputDecoration(),
                                        )
                                      : Text(
                                          titleController.text,
                                          style: const TextStyle(
                                              fontSize: 21,
                                              color: Colors.black),
                                        ),
                                  Text(
                                    subtitle.replaceAll(",", "\n"),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (edit == true) {
                                await userProvider
                                    .updateProfileName(titleController.text);
                              }
                              setState(() {
                                edit = !edit;
                              });
                            },
                            icon: Icon(
                              edit == true
                                  ? Icons.check_circle_outline
                                  : Icons.edit_outlined,
                              color: edit == true
                                  ? primaryGreen
                                  : primaryGreyColor,
                            ),
                          )
                        ],
                      ),
                      // if (userProvider.role == unitPresident)
                      // edit == true
                      //     ? Container(
                      //         height: 50,
                      //         width: MediaQuery.of(context).size.width / 1.5,
                      //         child: Container(
                      //           height: 35,
                      //           child: TextField(
                      //             controller: subtitleController,
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.grey.shade600),
                      //             decoration: const InputDecoration(),
                      //           ),
                      //         ),
                      //       )
                      //     :
                      // Text(
                      //   subtitleController.text,
                      //   style: TextStyle(fontSize: 18, color: Colors.black),
                      // ),
                    ],
                  ),
                ),
                const MemberCountSection(),
                // Padding(
                //   padding: const EdgeInsets.only(top: 30),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           memberModal(context, "Members", "members", true);
                //         },
                //         child: MemberBox(
                //           isLoading: memberProvider.loading,
                //           title: " Members",
                //           count: memberProvider.members.length.toString(),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           memberModal(
                //               context, "Primary Members", "primarymembers", false);
                //         },
                //         child: MemberBox(
                //             isLoading: memberProvider.loading,
                //             title: "Primary Members",
                //             count: memberProvider.primaryMembers.length.toString()),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 25,
                ),
                const NotificationHorizontalList(),
                for (HierarchyInfoModel hierarchyInfo
                    in hirarchiProvider.hierarchyinfolist)
                  HierarchySummaryCard(hirarchyInfo: hierarchyInfo),
                const MessageSectionCard(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Monthly reports",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get current month report
                        // if exist
                        //  check draft
                        //      open -
                        // else
                        // show snackbar
                        // else
                        //  normal
                        String curmonth =
                            DateFormat('MMMM').format(DateTime.now());

                        QAmodel? curmonthsqa;
                        try {
                          curmonthsqa = questionsProvider.submittedqalist
                              .firstWhere((element) =>
                                  element.submittedMonth == curmonth);
                        } catch (ex) {
                          print("In Submitted report");
                          print(ex);
                        }

                        if (curmonthsqa != null) {
                          showSnackbar(
                              context: context,
                              text: "Already submitted the report");
                          return;
                        }

                        QAmodel? curmonthdraftqa;
                        try {
                          curmonthdraftqa = questionsProvider.draftqalist
                              .firstWhere((element) =>
                                  element.submittedMonth == curmonth);
                        } catch (ex) {
                          print("In drafts");
                          print(ex);
                        }

                        if (curmonthdraftqa != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => AddReport(
                                draft: true,
                                edit: true,
                                qAmodel: curmonthdraftqa,
                              ),
                            ),
                          );
                        } else {
                          Navigator.pushNamed(context, AddReport.id);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 120,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: const Color(0xffEEEEEE),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryRed,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text(
                                "Add report",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //  for(QuestionnaireModel qmodel in questionsProvider.answersList)
                      for (int i = 0;
                          i <
                              (questionsProvider.submittedqalist.length > 3
                                  ? 3
                                  : questionsProvider.submittedqalist.length);
                          i++)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => AddReport(
                                  edit: true,
                                  qAmodel: questionsProvider.submittedqalist[i],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xffEEEEEE)),
                              ),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                questionsProvider
                                    .submittedqalist[i].submittedMonth,
                                style: const TextStyle(color: primaryGreen),
                              ),
                              subtitle: Text(
                                  "Submitted on ${questionsProvider.submittedqalist[i].submittedOn}"),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (questionsProvider.submittedqalist.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SubmittedReportList.id);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "View all",
                          style: TextStyle(
                              color: primaryRed, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                if (questionsProvider.submittedqalist.isNotEmpty)
                  const SizedBox(
                    height: 30,
                  ),
                SizedBox(
                  height: 107,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GradientButton(
                                title: "Family",
                                icon: "assets/icons/family.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GradientButton(
                                title: "Focus Ward",
                                icon: "assets/icons/2285040.png"),
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     GradientButton(
                      //         title: "Attendence",
                      //         icon: "assets/icons/attendence.png"),
                      //     GradientButton(
                      //         title: "Projects",
                      //         icon: "assets/icons/project.png"),
                      //   ],
                      // ),
                    ],
                  ),
                )
              ],
            ),
            if (memberProvider.loading ||
                questionsProvider.loading ||
                hirarchiProvider.loading ||
                Provider.of<NotificationProvider>(context, listen: false)
                    .loading)
              const WaveLoader()
          ],
        ),
      );
    });
  }
}

class GradientButton extends StatelessWidget {
  String title;
  String icon;
  GradientButton({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width / 2 - 16,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 3,
            color: Colors.grey.shade300,
          ),
        ],
        gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff3C7252),
              Color(0xff44C576),
            ]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          SizedBox(width: 30, height: 30, child: Image.asset(icon))
        ],
      ),
    );
  }
}
