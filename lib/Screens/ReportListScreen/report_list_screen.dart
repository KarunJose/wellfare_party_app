import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/models/qustionnaire_model.dart';
import 'package:wellfare_party_app/providers/questions_provider.dart';

class ReportListScreen extends StatefulWidget {
  static const String id = "reportlistScreen";

  ReportListScreen({super.key});

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Report List",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<QuestionsProvider>(
        builder: (context, questionProvider, child) => ListView(children: [
          for (QuestionnaireModel qmodal in questionProvider.questionList)
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "title",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("20/03/1994"),
                ],
              ),
            )),
        ]),
      ),
    );
  }
}
