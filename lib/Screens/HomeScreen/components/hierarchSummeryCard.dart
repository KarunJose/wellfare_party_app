import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/components/singleSummarybox.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/view/constituencyList.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/view/officeList.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/view/panchayatList.dart';
import 'package:wellfare_party_app/models/hierarchiInfoModel.dart';
import 'package:wellfare_party_app/providers/constituencyList_provider.dart';
import 'package:wellfare_party_app/providers/panchayat_provider.dart';

class HierarchySummaryCard extends StatefulWidget {
  HierarchyInfoModel hirarchyInfo;
  HierarchySummaryCard({
    required this.hirarchyInfo,
    Key? key,
  }) : super(key: key);

  @override
  State<HierarchySummaryCard> createState() => _HierarchySummaryCardState();
}

class _HierarchySummaryCardState extends State<HierarchySummaryCard> {

   bool showProviders = false;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showProviders = false;
  }


onButtonTapped() {
  print('onTapButton called');
  setState(() {
    showProviders = true;
  });
  print('showProviders: $showProviders');
}


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
            color: const Color(0xffEEEEEE),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.hirarchyInfo.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Builder(
                  builder: (context) {
                    if (showProviders) {
                      print('Show Providers');
                      return Consumer<ConstituencyProvider>(
                      builder: (context, constituencyProvider, child) {
                        return GestureDetector(
                          onTap: () {
                            constituencyProvider.getConstituencyList();
                            Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => (
                                      const   ConstituencyDetailScreen()
                                            ),
                                      ),
                                    );
                          },
                          child: SingleSummaryBox(
                              icon: "assets/icons/svgicons/hierarchyicon.svg",
                              title: widget.hirarchyInfo.title,
                              count: widget.hirarchyInfo.total.toString()),
                        );
                      }
                    );
                    } else {
                      print('show panchayat providers');
                      return Consumer<PanchayatProvider>(
                      builder: (context, panchayatProvider, child) {
                        return GestureDetector(
                          onTap: () {
                            
                            panchayatProvider.getPanchayatList();
                            Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => (
                                      const   PanchayatList()
                                            ),
                                      ),
                                    );
                          },
                          child: SingleSummaryBox(
                              icon: "assets/icons/svgicons/hierarchyicon.svg",
                              title: widget.hirarchyInfo.title,
                              count: widget.hirarchyInfo.total.toString()),
                        );
                      }
                    );
                    }
                  }
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => (
                                  const   OfficeList()
                                        ),
                                  ),
                                );
                  },
                  child: SingleSummaryBox(
                      icon: "assets/icons/svgicons/admin.svg",
                      title: "Admins",
                      count: widget.hirarchyInfo.admins.toString()),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => (
                                  const   OfficeList()
                                        ),
                                  ),
                                );
                  },
                  
                  child: SingleSummaryBox(
                      icon: "assets/icons/svgicons/officebeirer.svg",
                      title: "Office Bearer",
                      count: widget.hirarchyInfo.officeBearers.toString()),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => (
                                  const   OfficeList()
                                        ),
                                  ),
                                );
                  },
                  
                  child: SingleSummaryBox(
                      icon: "assets/icons/svgicons/report.svg",
                      title: "Reports",
                      count: widget.hirarchyInfo.reports.toString()),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
