import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/providers/report_provider.dart';

class ReportSearchResult extends StatefulWidget {
  static const String id = "reportSearch";
  const ReportSearchResult({Key? key}) : super(key: key);

  @override
  State<ReportSearchResult> createState() => _ReportSearchResultState();
}

class _ReportSearchResultState extends State<ReportSearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: primaryGreen),
        title: const Text(
          "Report Search result",
          style: TextStyle(color: primaryGreen, fontSize: 16),
        ),
      ),
      body: Consumer<ReportProvider>(
        builder: (context, reportProvider, child) => SingleChildScrollView(
          child: reportProvider.loading == true
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Center(
                      child: SpinKitWave(
                    color: primaryGreen,
                    size: 20.0,
                  )),
                )
              : Column(
                  children: [
                    for (var repo in reportProvider.reportResults)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: repo.memberName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: " [${repo.designationName}]",
                                        style: const TextStyle(
                                          color: primaryRed,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (repo.stateName != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text("State : ${repo.stateName} "),
                                ),
                              if (repo.districtName != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child:
                                      Text("District : ${repo.districtName}"),
                                ),
                              if (repo.constituencyName != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                      "Constituency : ${repo.constituencyName}"),
                                ),
                              if (repo.panchayathName != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                      "Panchayath : ${repo.panchayathName}"),
                                ),
                              if (repo.wardName != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text("Ward : ${repo.wardName}"),
                                ),
                              if (repo.unitName != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text("Unit : ${repo.unitName}"),
                                ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
        ),
      ),
    );
  }
}
