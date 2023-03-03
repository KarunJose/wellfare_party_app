import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/qa_model.dart';
import 'package:wellfare_party_app/models/qustionnaire_model.dart';

import 'package:wellfare_party_app/providers/questions_provider.dart';

import '../ReportData/add_report_screen.dart';

class SubmittedReportList extends StatefulWidget {
  static const String id = "submittedReportList";
  const SubmittedReportList({super.key});

  @override
  State<SubmittedReportList> createState() => _SubmittedReportListState();
}

class _SubmittedReportListState extends State<SubmittedReportList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() {
    var answerPov = Provider.of<QuestionsProvider>(context, listen: false);
    answerPov.getSubmittedAnswersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Reports",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Consumer<QuestionsProvider>(
        builder: (context, questionProvider, child) => Stack(
          children: [
            ListView(children: [
              for (QAmodel amodel in questionProvider.submittedqalist)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => AddReport(
                          edit: true,
                          qAmodel: amodel,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffEEEEEE))),
                    child: ListTile(
                      title: Text(
                        amodel.submittedMonth,
                        style: const TextStyle(color: textGreenColor),
                      ),
                      subtitle: Text("Submitted on ${amodel.submittedOn}"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: textGreenColor,
                      ),
                    ),
                  ),
                ),
            ]),
            questionProvider.loading == true ? const WaveLoader() : Container()
          ],
        ),
      ),
    );
  }
}
