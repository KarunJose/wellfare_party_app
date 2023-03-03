// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/api/member_api.dart';
import 'package:wellfare_party_app/commonComponents/HeirarchyFilttering/heirarchyfiltering.dart';
import 'package:wellfare_party_app/models/constituency_model.dart';
import 'package:wellfare_party_app/models/district_model.dart';
import 'package:wellfare_party_app/models/loginUserModel.dart';
import 'package:wellfare_party_app/models/member_model.dart';
import 'package:wellfare_party_app/models/panchayath_model.dart';
import 'package:wellfare_party_app/models/state_model.dart';
import 'package:wellfare_party_app/models/unit_model.dart';
import 'package:wellfare_party_app/models/user_role_model.dart';
import 'package:wellfare_party_app/models/ward_model.dart';
import 'package:wellfare_party_app/providers/bearer_provider.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/report_provider.dart';
import 'package:wellfare_party_app/providers/userrole_provider.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

class AddLoginUsers extends StatefulWidget {
  static const String id = "addloginscreen";
  final bool edit;
  final LoginUserModel? loginuser;
  const AddLoginUsers({
    Key? key,
    this.edit = false,
    this.loginuser,
  }) : super(key: key);

  @override
  State<AddLoginUsers> createState() => _AddLoginUsersState();
}

class _AddLoginUsersState extends State<AddLoginUsers> {
  TextEditingController userNameController = TextEditingController();
  bool usernamInvalid = false;
  TextEditingController passwordController = TextEditingController();
  bool passwordInvalid = false;

  String userType = "";

  UserRoleModel? selectedRolemodel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    await Provider.of<UserRoleProvider>(context, listen: false)
        .selectUserRole(null);
    await Provider.of<UserRoleProvider>(context, listen: false)
        .selectMember(null);
    await Provider.of<UserRoleProvider>(context, listen: false)
        .fetchUserRoles();

    // Provider.of<MemberProvder>(context, listen: false).getPrimaryMembers();
    var reportPov = Provider.of<ReportProvider>(context, listen: false);
    var bearerPov = Provider.of<BearerProvider>(context, listen: false);
    var rolepov = Provider.of<UserRoleProvider>(context, listen: false);
    var hierarchypov = Provider.of<HeirarchyProvider>(context, listen: false);
    var memberpov = Provider.of<MemberProvder>(context, listen: false);

    memberpov.getMembers(memberType: 'Member');

    rolepov.resetData();

    // if (widget.edit == true) {
    //   await hierarchypov.getState();
    //   await hierarchypov.selectState(widget.loginuser!.stateId);

    //   // await hierarchypov.getDistrict(widget.loginuser!.stateId);
    //   await hierarchypov.selectDistrict(widget.loginuser!.districtId);

    //   // await hierarchypov.getConstituency(widget.loginuser!.districtId);
    //   await hierarchypov.selectConstituency(widget.loginuser!.constituencyId);

    //   print("llllllllllllllllllllll");
    //   print(widget.loginuser!.panchayathId);
    //   print(widget.loginuser!.constituencyId);
    //   // await hierarchypov.getPanchayth(widget.loginuser!.constituencyId);
    //   await hierarchypov.selectPanchayath(widget.loginuser!.panchayathId);

    //   await hierarchypov.getUnit(widget.loginuser!.panchayathId);
    //   await hierarchypov.selectWard(widget.loginuser!.wardId);
    //   await hierarchypov.selectUnit(widget.loginuser!.unitId);
    // }

    await reportPov.getState();

    final prefs = await SharedPreferences.getInstance();
    final user_type = prefs.getString('user_type');
    final master_id = prefs.getString('master_id');

    setState(() {
      userType = user_type.toString();
    });

    if (widget.edit == true) {
      try {
        var rolemod = rolepov.userRoles
            .firstWhere((element) => element.id == widget.loginuser!.role);
        selectedRolemodel = rolemod;
        rolepov.selectUserRole(rolemod);
      } catch (ex) {
        print(ex);
      }

      setState(() {
        userNameController.text = widget.loginuser!.username;
        passwordController.text = widget.loginuser!.password;
      });
      rolepov.selectStatus(
          widget.loginuser!.status == "0" ? "Inactive" : "Active");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "App Admin Management",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Consumer4<UserRoleProvider, MemberProvder, ReportProvider,
          HeirarchyProvider>(
        builder: (context, userRoleProvider, memberprovider, reportProvider,
                hierarchyProvider, child) =>
            SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeirarchyFilttering(
                    edit: widget.edit,
                    entity: widget.loginuser,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "User role",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
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
                      // child: Text("dd"),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<UserRoleModel>(
                            dropdownColor: const Color(0xFFFFFFFF),
                            value: userRoleProvider.userRoleDropDownValue,
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            elevation: 16,
                            style: const TextStyle(
                                color: primaryGreyColor,
                                fontWeight: FontWeight.w500),
                            onChanged: (UserRoleModel? newValue) {
                              userRoleProvider.selectUserRole(newValue);
                            },
                            items: userRoleProvider.userRoles
                                .map<DropdownMenuItem<UserRoleModel>>(
                                    (UserRoleModel value) {
                              return DropdownMenuItem<UserRoleModel>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (userRoleProvider.userRoleInvalid == true)
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "*Select user role",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      widget.edit == true ? "Member" : "Members",
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  widget.edit == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Text(widget.loginuser!.name),
                        )
                      : Padding(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButton<dynamic>(
                                  dropdownColor: const Color(0xFFFFFFFF),
                                  value: userRoleProvider.memberDropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down_sharp),
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: primaryGreyColor,
                                      fontWeight: FontWeight.w500),
                                  onChanged: (dynamic newValue) {
                                    userRoleProvider.selectMember(newValue);
                                  },
                                  items: memberprovider.members
                                      .sublist(
                                          0,
                                          hierarchyProvider.unitDropdownValue ==
                                                      "All" ||
                                                  memberprovider.loading == true
                                              ? 0
                                              : memberprovider.members.length)
                                      .map<DropdownMenuItem<Member>>(
                                          (Member value) {
                                    return DropdownMenuItem<Member>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                  if (userRoleProvider.memberInvalid == true)
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "*Select member",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Status",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
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
                      // child: Text("dd"),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            dropdownColor: const Color(0xFFFFFFFF),
                            value: userRoleProvider.statusDropDown,
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            elevation: 16,
                            style: const TextStyle(
                                color: primaryGreyColor,
                                fontWeight: FontWeight.w500),
                            onChanged: (String? newValue) {
                              userRoleProvider.selectStatus(newValue);
                            },
                            items: userRoleProvider.status
                                .map<DropdownMenuItem<String>>((String value) {
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
                  if (userRoleProvider.statusInvalid == true)
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "*Select status",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Username",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primaryGreen)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                            controller: userNameController,
                            decoration: const InputDecoration(
                                hintText: "Username",
                                border: InputBorder.none)),
                      ),
                    ),
                  ),
                  if (usernamInvalid == true)
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "*username requierd",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Password",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primaryGreen)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none)),
                      ),
                    ),
                  ),
                  if (passwordInvalid == true)
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "*password requierd",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validation
                        bool error = false;
                        error = hierarchyProvider.checkDta() || error;
                        error =
                            userRoleProvider.checkUserRoleAndMember() || error;
                        error = userRoleProvider.checkstatus() || error;

                        if (userNameController.text == "") {
                          setState(() {
                            usernamInvalid = true;
                          });
                          return;
                        }
                        if (passwordController.text == "") {
                          setState(() {
                            passwordInvalid = true;
                          });
                          return;
                        }

                        if (error == true) {
                          return;
                        }

                        print("'============t");

                        if (widget.edit == true) {
                          await userRoleProvider.update(
                              stateDropDownValue:
                                  hierarchyProvider.stateDropDownValue,
                              districtDropdownValue:
                                  hierarchyProvider.districtDropdownValue,
                              constituencyDropdownValue:
                                  hierarchyProvider.constituencyDropdownValue,
                              panchayathDropdownValue:
                                  hierarchyProvider.panchayathDropdownValue,
                              wardDropdownValue:
                                  hierarchyProvider.wardDropdownValue,
                              unitDropdownValue:
                                  hierarchyProvider.unitDropdownValue,
                              username: userNameController.text,
                              password: passwordController.text,
                              memberid: widget.loginuser!.memberId,
                              memberLoginId: widget.loginuser!.id);
                        } else {
                          await userRoleProvider.save(
                            stateDropDownValue:
                                hierarchyProvider.stateDropDownValue,
                            districtDropdownValue:
                                hierarchyProvider.districtDropdownValue,
                            constituencyDropdownValue:
                                hierarchyProvider.constituencyDropdownValue,
                            panchayathDropdownValue:
                                hierarchyProvider.panchayathDropdownValue,
                            wardDropdownValue:
                                hierarchyProvider.wardDropdownValue,
                            unitDropdownValue:
                                hierarchyProvider.unitDropdownValue,
                            username: userNameController.text,
                            password: passwordController.text,
                          );
                        }

                        Navigator.pop(context);
                        showSnackbar(
                            context: context,
                            text: widget.edit == true
                                ? "App admin updated successfully"
                                : "App admin added successfully");
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 40),
                          primary: primaryGreen),
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
              if (memberprovider.loading == true ||
                  hierarchyProvider.loading == true)
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.7),
                  child: const Center(
                      child: SpinKitWave(
                    color: primaryGreen,
                    size: 20.0,
                  )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
