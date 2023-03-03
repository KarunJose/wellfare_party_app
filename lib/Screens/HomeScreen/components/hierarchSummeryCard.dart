import 'package:flutter/material.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/components/singleSummarybox.dart';
import 'package:wellfare_party_app/models/hierarchiInfoModel.dart';

class HierarchySummaryCard extends StatelessWidget {
  HierarchyInfoModel hirarchyInfo;
  HierarchySummaryCard({
    required this.hirarchyInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffEEEEEE),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hirarchyInfo.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SingleSummaryBox(
                    icon: "assets/icons/svgicons/hierarchyicon.svg",
                    title: hirarchyInfo.title,
                    count: hirarchyInfo.total.toString()),
                SingleSummaryBox(
                    icon: "assets/icons/svgicons/admin.svg",
                    title: "Admins",
                    count: hirarchyInfo.admins.toString()),
                SingleSummaryBox(
                    icon: "assets/icons/svgicons/officebeirer.svg",
                    title: "Office Bearer",
                    count: hirarchyInfo.officeBearers.toString()),
                SingleSummaryBox(
                    icon: "assets/icons/svgicons/report.svg",
                    title: "Reports",
                    count: hirarchyInfo.reports.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
