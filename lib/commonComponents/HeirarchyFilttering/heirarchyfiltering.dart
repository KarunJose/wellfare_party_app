import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/models/constituency_model.dart';
import 'package:wellfare_party_app/models/district_model.dart';
import 'package:wellfare_party_app/models/panchayath_model.dart';
import 'package:wellfare_party_app/models/state_model.dart';
import 'package:wellfare_party_app/models/unit_model.dart';
import 'package:wellfare_party_app/models/ward_model.dart';

import 'package:wellfare_party_app/providers/heirarchy_provider.dart';

class HeirarchyFilttering extends StatefulWidget {
  bool showTitle;
  dynamic entity;
  bool edit;
  bool all;
  bool ward;
  Function? filterCallBack;
  HeirarchyFilttering({
    Key? key,
    this.showTitle = true,
    this.edit = false,
    this.entity,
    this.all = false,
    this.ward = false,
    this.filterCallBack,
  }) : super(key: key);

  @override
  State<HeirarchyFilttering> createState() => _HeirarchyFiltteringState();
}

class _HeirarchyFiltteringState extends State<HeirarchyFilttering> {
  TextEditingController userNameController = TextEditingController();
  bool usernamInvalid = false;
  TextEditingController passwordController = TextEditingController();
  bool passwordInvalid = false;

  String userType = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    // Provider.of<MemberProvder>(context, listen: false).getPrimaryMembers();

    var hierarchyPov = Provider.of<HeirarchyProvider>(context, listen: false);

    final prefs = await SharedPreferences.getInstance();
    final user_type = prefs.getString('user_type');

    setState(() {
      userType = user_type.toString();
    });

    hierarchyPov.setInitialData(
      all: widget.all,
      context: context,
      edit: widget.edit,
      entity: widget.entity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeirarchyProvider>(
      builder: (context, hierarchyProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //state
          if (widget.showTitle == true)
            if (userType == "state")
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 5,
                ),
                child: Text(
                  "State",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          if (userType == "state")
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
                bottom: 5,
              ),
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
                      value: hierarchyProvider.stateDropDownValue,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: primaryGreyColor, fontWeight: FontWeight.w500),
                      onChanged: (String? newValue) {
                        hierarchyProvider.getDistrict(newValue!);
                        hierarchyProvider.selectState(newValue);
                        hierarchyProvider.selectDistrict("Select District");
                      },
                      items: hierarchyProvider.state
                          .map<DropdownMenuItem<String>>((StateModel value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.stateName),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          if (hierarchyProvider.stateInValid == true)
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "*State requierd",
                style: TextStyle(color: Colors.red),
              ),
            ),
          //district
          if (widget.showTitle == true)
            if (userType == "state")
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 5,
                ),
                child: Text(
                  "District",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          if (userType == "state")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      value: hierarchyProvider.districtDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: primaryGreyColor, fontWeight: FontWeight.w500),
                      onChanged: (String? newValue) {
                        hierarchyProvider.getConstituency(newValue!);
                        hierarchyProvider.selectDistrict(newValue);
                        hierarchyProvider
                            .selectConstituency("Select Constituency");
                      },
                      items: hierarchyProvider.district
                          .map<DropdownMenuItem<String>>((DistrictModel value) {
                        return DropdownMenuItem<String>(
                          value: value.districtId,
                          child: Text(value.districtName),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          if (hierarchyProvider.districtInValid == true)
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "*District requierd",
                style: TextStyle(color: Colors.red),
              ),
            ),
          //constituency
          if (widget.showTitle == true)
            if (userType == "state" || userType == "district")
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 5,
                ),
                child: Text(
                  "Constituency",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          if (userType == "state" || userType == "district")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      value: hierarchyProvider.constituencyDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: primaryGreyColor, fontWeight: FontWeight.w500),
                      onChanged: (String? newValue) {
                        if (newValue != "Select Constituency") {
                          hierarchyProvider.getPanchayth(newValue!);
                        }

                        hierarchyProvider.selectConstituency(newValue);
                        hierarchyProvider.selectPanchayath("Select Panchayath");
                      },
                      items: hierarchyProvider.constituency
                          .map<DropdownMenuItem<String>>(
                              (ConstituencyModel value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.constituencyName),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          if (hierarchyProvider.constituencyInValid == true)
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "*Constituency requierd",
                style: TextStyle(color: Colors.red),
              ),
            ),

          //panchayath
          if (widget.showTitle == true)
            if (userType == "state" ||
                userType == "district" ||
                userType == "constituency")
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 5,
                ),
                child: Text(
                  "Panchayath",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          if (userType == "state" ||
              userType == "district" ||
              userType == "constituency")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      value: hierarchyProvider.panchayathDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: primaryGreyColor, fontWeight: FontWeight.w500),
                      onChanged: (String? newValue) {
                        hierarchyProvider.getWard(newValue!);
                        hierarchyProvider.getUnit(newValue);
                        hierarchyProvider.selectPanchayath(newValue);
                        hierarchyProvider.selectWard("Select Ward");
                        hierarchyProvider.selectUnit("Select Unit");
                      },
                      items: hierarchyProvider.panchayath
                          .map<DropdownMenuItem<String>>(
                              (PanchayathModel value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.panchayathName),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          if (hierarchyProvider.panchayathInValid == true)
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "*Panchayath requierd",
                style: TextStyle(color: Colors.red),
              ),
            ),

          // Ward
          if (widget.ward == true)
            if (widget.showTitle == true)
              if (userType == "state" ||
                  userType == "district" ||
                  userType == "constituency" ||
                  userType == "panchayath")
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 15,
                    bottom: 5,
                  ),
                  child: Text(
                    "Ward",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
          if (widget.ward == true)
            if (userType == "state" ||
                userType == "district" ||
                userType == "constituency" ||
                userType == "panchayath")
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        dropdownColor: const Color(0xFFFFFFFF),
                        value: hierarchyProvider.wardDropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        elevation: 16,
                        style: const TextStyle(
                            color: primaryGreyColor,
                            fontWeight: FontWeight.w500),
                        onChanged: (String? newValue) {
                          hierarchyProvider.selectWard(newValue);
                        },
                        items: hierarchyProvider.ward
                            .map<DropdownMenuItem<String>>((Ward value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
                            child: Text(value.ward),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 10),
          //   child: Text(
          //     "*Ward requierd",
          //     style: TextStyle(color: Colors.red),
          //   ),
          // ),
          //unit
          if (widget.showTitle == true)
            if (userType == "state" ||
                userType == "district" ||
                userType == "constituency" ||
                userType == "panchayath" ||
                userType == "ward")
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 5,
                ),
                child: Text(
                  "Unit",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          if (userType == "state" ||
              userType == "district" ||
              userType == "constituency" ||
              userType == "panchayath" ||
              userType == "ward")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFFFFFFFF),
                      value: hierarchyProvider.unitDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: primaryGreyColor, fontWeight: FontWeight.w500),
                      onChanged: (String? newValue) {
                        hierarchyProvider.selectUnit(newValue);
                        if (widget.filterCallBack != null) {
                          widget.filterCallBack!();
                        }
                      },
                      items: hierarchyProvider.unit
                          .map<DropdownMenuItem<String>>((UnitModel value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.unitName),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

          if (hierarchyProvider.unitInvalid == true)
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "*Unit requierd",
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
