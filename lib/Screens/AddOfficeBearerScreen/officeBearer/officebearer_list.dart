import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/AddOfficeBearerScreen/add_office_bearer.dart';
import 'package:wellfare_party_app/commonComponents/HeirarchyFilttering/heirarchyfiltering.dart';
import 'package:wellfare_party_app/commonComponents/BearerCard/bearer_card.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/designation_model.dart';
import 'package:wellfare_party_app/providers/bearer_provider.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/report_provider.dart';
import '../../../MainConst/main_const.dart';

class OfficeBearerListScreen extends StatefulWidget {
  static const String id = "officebearerList";

  OfficeBearerListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OfficeBearerListScreen> createState() => _OfficeBearerListScreenState();
}

class _OfficeBearerListScreenState extends State<OfficeBearerListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    var reportPov = Provider.of<ReportProvider>(context, listen: false);
    var bearerPov = Provider.of<BearerProvider>(context, listen: false);

    await bearerPov.resetdata();
    await reportPov.getDesignation();
    // await bearerPov.getOfficeBearerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Office Bearers",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {
                var bearerPov =
                    Provider.of<BearerProvider>(context, listen: false);
                bearerPov.resetdata();
                var hierarchypov =
                    Provider.of<HeirarchyProvider>(context, listen: false);
                hierarchypov.resetData();
              },
              icon: Icon(Icons.sync)),
        ],
      ),
      floatingActionButton: Container(
        height: 40.0,
        width: 40.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: textGreenColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddOfficeBearer.id);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer4<BearerProvider, ReportProvider, MemberProvder,
            HeirarchyProvider>(
          builder: (context, bearerProvider, reportProvider, memberProvider,
                  hierarchyProvider, child) =>
              Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 55, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeirarchyFilttering(showTitle: false),
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
                              value: bearerProvider.designationDropDownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                bearerProvider
                                    .setdesignationDropDownValue(newValue!);
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              dropdownColor: const Color(0xFFFFFFFF),
                              value: bearerProvider.statusDropDown,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                bearerProvider.selectStatus(newValue);
                              },
                              items: bearerProvider.status
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
                              fixedSize: Size(120, 35)),
                          onPressed: () {
                            bearerProvider.getOfficeBearerList(
                              designation:
                                  bearerProvider.designationDropDownValue,
                              stateId: hierarchyProvider.stateDropDownValue,
                              districtId:
                                  hierarchyProvider.districtDropdownValue,
                              constId:
                                  hierarchyProvider.constituencyDropdownValue,
                              panchayathId:
                                  hierarchyProvider.panchayathDropdownValue,
                              wardId: hierarchyProvider.wardDropdownValue,
                              unitId: hierarchyProvider.unitDropdownValue,
                            );
                          },
                          child: const Text(
                            "Filter",
                            style: TextStyle(fontSize: 16, letterSpacing: 0.5),
                          )),
                    ),
                    for (var bearer in bearerProvider.bearerList)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => AddOfficeBearer(
                                edit: true,
                                bearer: bearer,
                              ),
                            ),
                          );
                        },
                        child: BearerCard(
                          bearerList: bearer,
                        ),
                      ),
                  ],
                ),
              ),
              if (bearerProvider.loading == true ||
                  hierarchyProvider.loading == true)
                const WaveLoader()
            ],
          ),
        ),
      ),
    );
  }
}
