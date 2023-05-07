import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/commonComponents/HeirarchyFilttering/heirarchyfiltering.dart';
import 'package:wellfare_party_app/models/member_model.dart';
import 'package:wellfare_party_app/models/position_model.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/position_provider.dart';
import 'package:wellfare_party_app/providers/userprovider.dart';
import 'package:wellfare_party_app/providers/ward_provider.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

import '../../models/ward_model.dart';

class AddMemberScreen extends StatefulWidget {
  static const String id = "AddMemberScreen";
  final bool edit;
  final Member? member;
  final bool show;

  const AddMemberScreen({
    Key? key,
    this.edit = false,
    this.member,
    this.show = false,
  }) : super(key: key);

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController participationDateController = TextEditingController();

  int value = 1;
  bool checkBoxValue = false;

  // Position dropdownValue = Position(id: "0", position: "");
  // Ward warddropdownValue = Ward(
  //     id: "0",
  //     ward: "",
  //     wardcorde: "",
  //     constituencyId: "",
  //     districtId: "",
  //     panchayathId: "",
  //     stateId: "");
  List<String> items = [
    "",
    "O +ve",
    "O -ve",
    "A +ve",
    "A -ve",
    "B +ve",
    "B -ve",
    "AB +ve",
    "AB -ve",
  ];

  List<String> years = ["Admission Year"];
  String selectedAdmissionYear = "Admission Year";

  String selectedBloodGroup = "";
  final _formKey = GlobalKey<FormState>();

  bool bloodgrpValid = true;
  bool admissionYrValid = true;
  bool participationDtValid = true;
  bool positionValid = true;
  bool wardValid = true;

  bool firstValidation = true;

  @override
  void initState() {
    super.initState();

    selectedBloodGroup = items[0];

    for (var i = 2030; i >= 1900; i--) {
      years.add(i.toString());
    }

    selectedAdmissionYear = years[0];

    if (widget.edit == true) {
      setState(() {
        nameController.text = widget.member!.name;

        checkBoxValue = widget.member!.memberType == "Member" ? true : false;

        var strToDateTime = DateTime.parse(widget.member!.dob.toString());
        var convertLocal = strToDateTime.toLocal();
        var newFormat = DateFormat("dd-MM-yyyy");
        dobController.text = newFormat.format(convertLocal);

        ageController.text = widget.member!.age;
        if (widget.member!.bloodGroup != null) {
          bloodController.text = widget.member!.bloodGroup!;
        }

        mobileController.text = widget.member!.mobile;
        emailController.text = widget.member!.email;
        addressController.text = widget.member!.address;

        if (widget.member!.participationDate != null) {
          strToDateTime =
              DateTime.parse(widget.member!.participationDate.toString());
          convertLocal = strToDateTime.toLocal();
          newFormat = DateFormat("dd-MM-yyyy");
          participationDateController.text = newFormat.format(convertLocal);
        }

        if (widget.member!.gender == "Male") {
          value = 1;
        } else {
          value = 2;
        }

        try {
          selectedBloodGroup = items
              .firstWhere((element) => widget.member!.bloodGroup == element);

          if (years.isNotEmpty && widget.member!.admissionYear != null) {
            selectedAdmissionYear = years.firstWhere((element) {
              return widget.member!.admissionYear == element;
            });
          }
        } catch (e) {
          print(e);
        }

        //  Ward and position dropdown in genInitialDetials()
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    // var posProv = Provider.of<PositionProvider>(context, listen: false);
    // await posProv.getPositions();
    // if (posProv.positions.isNotEmpty) {
    //   try {
    //     if (widget.edit == true) {
    //       dropdownValue = posProv.positions
    //           .firstWhere((element) => widget.member!.positions == element.id);
    //     } else {
    //       dropdownValue = posProv.positions.first;
    //     }
    //   } catch (e) {
    //     dropdownValue = posProv.positions.first;
    //   }
    // }

    // var wardProv = Provider.of<WardProvider>(context, listen: false);
    // await wardProv.getWard();
    // if (wardProv.wards.isNotEmpty) {
    //   if (widget.edit == true && widget.member!.wardId != null) {
    //     try {
    //       warddropdownValue = wardProv.wards
    //           .firstWhere((element) => widget.member!.wardId == element.id);
    //     } catch (e) {
    //       print(e);
    //       warddropdownValue = wardProv.wards.first;
    //     }
    //   } else {
    //     warddropdownValue = wardProv.wards.first;
    //   }
    // }
  }

  validateForm() {
    if (firstValidation == false) {
      !_formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var hierarchyPov =
            Provider.of<HeirarchyProvider>(context, listen: false);

        var membpov = Provider.of<MemberProvder>(context, listen: false);

        hierarchyPov.setInitialData(
            all: true, edit: false, context: context, entity: null);
        membpov.resetData();
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.show == true
                  ? "Member Details"
                  : "${widget.edit ? 'Update' : 'Add Primary Member'} ${widget.member != null ? widget.member!.memberType : ''}",
              style: const TextStyle(color: primaryGreen, fontSize: 16),
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.grey),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
            ],
          ),
          body: Consumer5<MemberProvder, PositionProvider, UserProvider,
                  WardProvider, HeirarchyProvider>(
              builder: (context, memberProvider, positionProvider, userProvider,
                  wardProvider, heirarchyProvider, child) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    //   child: Wrap(
                    //     direction: Axis.horizontal,
                    //     runSpacing: 5,
                    //     spacing: 10,
                    //     children: [
                    //       RichText(
                    //         text: const TextSpan(children: [
                    //           TextSpan(
                    //             text: "Paty Unit :",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //           TextSpan(
                    //             text: "Manjeri",
                    //             style: TextStyle(color: Colors.black),
                    //           )
                    //         ]),
                    //       ),
                    //       RichText(
                    //         text: const TextSpan(children: [
                    //           TextSpan(
                    //             text: "Constituency :",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //           TextSpan(
                    //             text: "Test",
                    //             style: TextStyle(color: Colors.black),
                    //           )
                    //         ]),
                    //       ),
                    //       RichText(
                    //         text: const TextSpan(children: [
                    //           TextSpan(
                    //             text: "District :",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //           TextSpan(
                    //             text: "Kasargode",
                    //             style: TextStyle(color: Colors.black),
                    //           )
                    //         ]),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    HeirarchyFilttering(
                      edit: widget.edit,
                      entity: widget.member,
                      ward: true,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldTitle(title: "Full Name"),
                    AddMemberTextField(
                      hint: "Full Name",
                      width: double.infinity,
                      controller: nameController,
                      enabled: !widget.show,
                      formValidator: (dynamic value) {
                        if (value.isEmpty) {
                          return 'add name';
                        }
                      },
                      onChanged: (String? value) {
                        validateForm();
                      },
                    ),

                    //dob
                    TextFieldTitle(title: "Date of Birth"),
                    GestureDetector(
                      onTap: () async {
                        if (widget.show == true) {
                          return;
                        }
                        DateTime now = DateTime.now();
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate:
                              now.subtract(const Duration(days: 365 * 18)),
                          firstDate: DateTime(1950),
                          lastDate:
                              now.subtract(const Duration(days: 365 * 18)),
                        );

                        setState(() {
                          if (date != null) {
                            var strToDateTime = DateTime.parse(date.toString());
                            final convertLocal = strToDateTime.toLocal();
                            var newFormat = DateFormat("dd-MM-yyyy");
                            dobController.text = newFormat.format(convertLocal);

                            int days = DateTime.now().difference(date).inDays;
                            ageController.text =
                                (days / 365).toStringAsFixed(0);
                          }
                        });
                      },
                      child: AddMemberTextField(
                        hint: "DOB",
                        width: double.infinity,
                        controller: dobController,
                        enabled: false,
                        formValidator: (dynamic value) {
                          if (value.isEmpty) {
                            return 'add date of birth';
                          }
                        },
                      ),
                    ),

                    //gender
                    TextFieldTitle(title: "Gender"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 45,
                        child: Row(
                          children: [
                            // ignore: avoid_unnecessary_containers
                            Container(
                              child: Row(
                                children: [
                                  const Text(
                                    "Male",
                                    style: TextStyle(
                                        fontSize: 16, color: primaryGreyColor),
                                  ),
                                  Radio(
                                      activeColor: primaryGreen,
                                      value: 1,
                                      groupValue: value,
                                      onChanged: (val) {
                                        if (widget.show == true) {
                                          return;
                                        }
                                        setState(() {
                                          value = int.parse(val.toString());
                                        });
                                      })
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  const Text(
                                    "Female",
                                    style: TextStyle(
                                        fontSize: 16, color: primaryGreyColor),
                                  ),
                                  Radio(
                                      activeColor: primaryGreen,
                                      value: 2,
                                      groupValue: value,
                                      onChanged: (val) {
                                        if (widget.show == true) {
                                          return;
                                        }
                                        setState(() {
                                          value = int.parse(val.toString());
                                        });
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //age and blood
                    Row(
                      children: [
                        Row(
                          children: [
                            TextFieldTitle(title: "Age"),
                            AddMemberTextField(
                              enabled: false,
                              hint: "Age",
                              controller: ageController,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 140,
                            ),
                          ],
                        ),
                        // AddMemberTextField(
                        //   hint: "Blood Group",
                        //   controller: bloodController,
                        //   width: (MediaQuery.of(context).size.width / 2) - 40,
                        // ),
                        Row(
                          children: [
                            TextFieldTitle(title: "Blood Groop"),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                height: 50,
                                width: (MediaQuery.of(context).size.width / 2) -
                                    120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: borderGrayColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: DropdownButton<String>(
                                        style: const TextStyle(
                                            color: primaryGreyColor),
                                        value: selectedBloodGroup,
                                        items: items
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.grey.shade400,
                                                      fontWeight: item == ""
                                                          ? FontWeight.w400
                                                          : FontWeight.normal),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: widget.show == true
                                            ? null
                                            : (item) {
                                                setState(() {
                                                  if (item != "") {
                                                    bloodgrpValid = true;
                                                    selectedBloodGroup = item!;
                                                  }
                                                });
                                              },
                                      )),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    if (bloodgrpValid == false)
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, bottom: 10),
                          child: Text(
                            "add blood group",
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                        ),
                      ),

                    //mobie number
                    TextFieldTitle(title: "Mobile"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("+91"),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: AddMemberTextField(
                              formValidator: (dynamic value) {
                                if (value.isEmpty || value.length != 10) {
                                  return 'invalid number';
                                }
                              },
                              hint: "Mobile",
                              width: double.infinity,
                              controller: mobileController,
                              keyboardType: TextInputType.number,
                              limit: 10,
                              enabled: !widget.show,
                              onChanged: (String? value) {
                                validateForm();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //email
                    TextFieldTitle(title: "Email"),
                    AddMemberTextField(
                      hint: "user@gmail.com",
                      width: double.infinity,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String? value) {
                        validateForm();
                      },
                      // formValidator: (dynamic value) {
                      //   // return validateEmail(value);
                      //   final bool isValid = EmailValidator.validate(value);
                      //   if (!isValid) {
                      //     return "Invalid email";
                      //   }
                      // },
                    ),
                    TextFieldTitle(title: "Address"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: borderGrayColor,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            enabled: !widget.show,
                            controller: addressController,
                            cursorColor: primaryGreen,
                            onChanged: (String? value) {
                              validateForm();
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "  Address"),
                            minLines: 6,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "add address";
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    TextFieldTitle(title: "Status"),
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
                              value: memberProvider.statusDropDown,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: const TextStyle(
                                  color: primaryGreyColor,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                memberProvider.selectStatus(newValue);
                              },
                              items: memberProvider.status
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
                    //check box
                    if (userProvider.role == districtPresident &&
                        widget.edit == true)
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            const Text(
                              "Approve as member",
                              style: TextStyle(fontSize: 16),
                            ),
                            Checkbox(
                                activeColor: primaryGreen,
                                value: checkBoxValue,
                                onChanged: widget.show == true
                                    ? null
                                    : (checkValue) {
                                        setState(() {
                                          checkBoxValue = checkValue!;
                                        });
                                      })
                          ],
                        ),
                      ),

                    //admission year
                    if (userProvider.role == districtPresident &&
                        widget.edit == true &&
                        checkBoxValue == true)
                      TextFieldTitle(title: "Addmission year"),
                    if (userProvider.role == districtPresident &&
                        widget.edit == true &&
                        checkBoxValue == true)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width) - 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: borderGrayColor,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: DropdownButton<String>(
                                style: const TextStyle(color: primaryGreyColor),
                                value: selectedAdmissionYear,
                                items: years
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                                  item == "Admission Year"
                                                      ? FontWeight.w500
                                                      : FontWeight.normal),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: widget.show == true
                                    ? null
                                    : (item) {
                                        setState(() {
                                          if (item != "Admission Year") {
                                            admissionYrValid = true;
                                            selectedAdmissionYear = item!;
                                          }
                                        });
                                      },
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (admissionYrValid == false)
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          "add admission year",
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ),

                    //participation date
                    if (userProvider.role == districtPresident &&
                        widget.edit == true &&
                        checkBoxValue == true)
                      TextFieldTitle(title: "Participation date"),
                    if (userProvider.role == districtPresident &&
                        widget.edit == true &&
                        checkBoxValue == true)
                      GestureDetector(
                        onTap: () async {
                          if (widget.show == true) {
                            return;
                          }
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );

                          setState(() {
                            if (date != null) {
                              if (participationDtValid == false) {
                                setState(() {
                                  participationDtValid = true;
                                });
                              }
                              var strToDateTime =
                                  DateTime.parse(date.toString());
                              final convertLocal = strToDateTime.toLocal();
                              var newFormat = DateFormat("dd-MM-yyyy");
                              participationDateController.text =
                                  newFormat.format(convertLocal);
                            }
                          });
                        },
                        child: AddMemberTextField(
                          hint: "Participation date",
                          width: double.infinity,
                          controller: participationDateController,
                          enabled: false,
                        ),
                      ),
                    if (participationDtValid == false)
                      const Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: Text(
                          "add participation date",
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ),

                    //ward
                    // TextFieldTitle(title: "Ward"),
                    // if (wardProvider.wards.isNotEmpty &&
                    //     warddropdownValue.ward != "")
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 20, vertical: 5),
                    //     child: Container(
                    //       height: 50,
                    //       width: double.infinity,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         boxShadow: [
                    //           BoxShadow(
                    //               blurRadius: 6,
                    //               spreadRadius: 2,
                    //               color: Colors.grey.shade200),
                    //         ],
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       child: DropdownButtonHideUnderline(
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //             horizontal: 10,
                    //           ),
                    //           child: DropdownButton<Ward>(
                    //             dropdownColor: Colors.white,
                    //             value: warddropdownValue,
                    //             icon: const Icon(Icons.arrow_drop_down_sharp),
                    //             elevation: 16,
                    //             style: const TextStyle(
                    //                 color: primaryGreyColor,
                    //                 fontWeight: FontWeight.w500),
                    //             onChanged: widget.show == true
                    //                 ? null
                    //                 : (Ward? newValue) {
                    //                     setState(() {
                    //                       warddropdownValue = newValue!;
                    //                     });
                    //                   },
                    //             items: wardProvider.wards
                    //                 .map<DropdownMenuItem<Ward>>((Ward value) {
                    //               return DropdownMenuItem<Ward>(
                    //                 value: value,
                    //                 child: Text(value.wardcorde == ""
                    //                     ? value.ward
                    //                     : "${value.ward} (${value.wardcorde})"),
                    //               );
                    //             }).toList(),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // if (wardValid == false)
                    //   const Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Padding(
                    //       padding: EdgeInsets.only(left: 20, bottom: 10),
                    //       child: Text(
                    //         "Select Ward",
                    //         style: TextStyle(fontSize: 12, color: Colors.red),
                    //       ),
                    //     ),
                    //   ),
                    //position
                    // if (positionProvider.positions.isNotEmpty &&
                    //     dropdownValue.position != "")
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 20, vertical: 5),
                    //     child: Container(
                    //       height: 50,
                    //       width: double.infinity,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         boxShadow: [
                    //           BoxShadow(
                    //               blurRadius: 6,
                    //               spreadRadius: 2,
                    //               color: Colors.grey.shade200),
                    //         ],
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       child: DropdownButtonHideUnderline(
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(horizontal: 10),
                    //           child: DropdownButton<Position>(
                    //             dropdownColor: Colors.white,
                    //             value: dropdownValue,
                    //             icon: const Icon(Icons.arrow_drop_down_sharp),
                    //             elevation: 16,
                    //             style: const TextStyle(
                    //                 color: primaryGreyColor,
                    //                 fontWeight: FontWeight.w500),
                    //             onChanged: widget.show == true
                    //                 ? null
                    //                 : (Position? newValue) {
                    //                     setState(() {
                    //                       dropdownValue = newValue!;
                    //                     });
                    //                   },
                    //             items: positionProvider.positions
                    //                 .map<DropdownMenuItem<Position>>(
                    //                     (Position value) {
                    //               return DropdownMenuItem<Position>(
                    //                 value: value,
                    //                 child: Text(value.position),
                    //               );
                    //             }).toList(),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // if (positionValid == false)
                    //   const Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Padding(
                    //       padding: EdgeInsets.only(left: 20, bottom: 10),
                    //       child: Text(
                    //         "Select position",
                    //         style: TextStyle(fontSize: 12, color: Colors.red),
                    //       ),
                    //     ),
                    //   ),
                    //address

                    const SizedBox(
                      height: 20,
                    ),

                    //button
                    if (memberProvider.loading == true)
                      const Center(child: CircularProgressIndicator())
                    else if (widget.show == false)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryRed,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width / 1.5, 45),
                            ),
                            onPressed: () async {
                              bool error = false;
                              setState(() {
                                firstValidation = false;
                              });
                              error = heirarchyProvider.checkDta() || error;
                              if (dobController.text == "" ||
                                  ageController.text == "" ||
                                  mobileController.text == "" ||
                                  addressController.text == "") {
                                showSnackbar(
                                    context: context, text: "Fill all details");
                              }

                              if (!_formKey.currentState!.validate()) return;

                              if (checkBoxValue == true) {
                                if (selectedAdmissionYear == "Admission Year" &&
                                    userProvider.role == districtPresident &&
                                    widget.edit == true) {
                                  setState(() {
                                    admissionYrValid = false;
                                  });
                                  return;
                                }

                                if (participationDateController.text.isEmpty &&
                                    userProvider.role == districtPresident &&
                                    widget.edit == true) {
                                  setState(() {
                                    participationDtValid = false;
                                  });
                                  return;
                                }
                              }

                              if (selectedBloodGroup == "Blood Group") {
                                setState(() {
                                  bloodgrpValid = false;
                                });
                                return;
                              }
                              if (error == true) {
                                return;
                              }

                              // if (warddropdownValue.id == "-1") {
                              //   showSnackbar(
                              //       context: context, text: "Select Ward");
                              // }

                              // if (dropdownValue.id == "-1") {
                              //   showSnackbar(
                              //       context: context, text: "Select Postion");
                              // }

                              if (widget.edit == true) {
                                await memberProvider.updateMember(
                                  id: widget.member!.id,
                                  status:
                                      memberProvider.statusDropDown == "Active"
                                          ? 1
                                          : 0,
                                  name: nameController.text,
                                  dob: dobController.text,
                                  gender: value == 1 ? "Male" : "Female",
                                  age: ageController.text,
                                  blood: selectedBloodGroup,
                                  mobile: mobileController.text,
                                  email: emailController.text,

                                  address: addressController.text,
                                  isAgree: checkBoxValue,
                                  adminssionYear:
                                      selectedAdmissionYear == "Admission Year"
                                          ? null
                                          : selectedAdmissionYear,
                                  participationDate:
                                      participationDateController.text.isEmpty
                                          ? null
                                          : participationDateController.text,
                                  //  warddropdownValue.id,
                                  stateId: heirarchyProvider.stateDropDownValue,
                                  districtId:
                                      heirarchyProvider.districtDropdownValue,
                                  constituencyId: heirarchyProvider
                                      .constituencyDropdownValue,
                                  panchayathId:
                                      heirarchyProvider.panchayathDropdownValue,
                                  wardId: heirarchyProvider.wardDropdownValue,
                                  unitId: heirarchyProvider.unitDropdownValue,
                                );
                              } else {
                                await memberProvider.addMember(
                                  name: nameController.text,
                                  dob: dobController.text,
                                  status:
                                      memberProvider.statusDropDown == "Active"
                                          ? 1
                                          : 0,
                                  gender: value == 1 ? "Male" : "Female",
                                  age: ageController.text,
                                  blood: selectedBloodGroup,
                                  mobile: mobileController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  isAgree: checkBoxValue,
                                  adminssionYear:
                                      selectedAdmissionYear == "Admission Year"
                                          ? null
                                          : selectedAdmissionYear,
                                  participationDate:
                                      participationDateController.text.isEmpty
                                          ? null
                                          : participationDateController.text,
                                  stateId: heirarchyProvider.stateDropDownValue,
                                  districtId:
                                      heirarchyProvider.districtDropdownValue,
                                  constituencyId: heirarchyProvider
                                      .constituencyDropdownValue,
                                  panchayathId:
                                      heirarchyProvider.panchayathDropdownValue,
                                  wardId: heirarchyProvider.wardDropdownValue,
                                  unitId: heirarchyProvider.unitDropdownValue,
                                );
                              }

                              // ignore: use_build_context_synchronously
                              // Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              heirarchyProvider.setInitialData(
                                all: true,
                                edit: false,
                                entity: null,
                                context: context,
                              );
                              Navigator.pop(context);
                              showSnackbar(
                                  context: context,
                                  text:
                                      "Member ${widget.edit ? 'Updated' : 'Created'}");
                            },
                            child: Text(
                              widget.edit ? "Update" : "Add",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class TextFieldTitle extends StatelessWidget {
  String title;
  TextFieldTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class AddMemberTextField extends StatefulWidget {
  String hint;
  double width;
  bool enabled;
  TextInputType? keyboardType;
  int? limit;

  String? Function(String?)? formValidator;
  Function(String?)? onChanged;

  TextEditingController controller;
  AddMemberTextField({
    required this.hint,
    required this.width,
    required this.controller,
    this.formValidator,
    this.keyboardType,
    this.enabled = true,
    this.limit,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<AddMemberTextField> createState() => _AddMemberTextFieldState();
}

class _AddMemberTextFieldState extends State<AddMemberTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 50,
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: borderGrayColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            onChanged: widget.onChanged,
            maxLength: widget.limit,
            validator: widget.formValidator,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            enabled: widget.enabled,
            cursorColor: primaryGreen,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint,
                counterText: "",
                hintStyle: TextStyle(fontSize: 13)),
          ),
        ),
      ),
    );
  }
}
