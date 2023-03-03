import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/commonComponents/HeirarchyFilttering/heirarchyfiltering.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/messageProvider.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

class SendMessageScreen extends StatefulWidget {
  static const String id = "sendmessage";

  SendMessageScreen({Key? key}) : super(key: key);

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  // List<File> attachments = [];
  File? attachment;
  dynamic recipientDropdownValue = 'Select Member';
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    await Provider.of<MemberProvder>(context, listen: false).resetData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<MessageProvider, MemberProvder, HeirarchyProvider>(
      builder: (context, messageProvider, memberProvider, heirarchyProvider,
              child) =>
          Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Send Message",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  File file = File(result.files.single.path!);
                  setState(() {
                    attachment = file;
                  });
                } else {
                  // User canceled the picker
                }
              },
              icon: const Icon(
                Icons.attach_file,
              ),
            ),
            IconButton(
              onPressed: () async {
                await messageProvider.sendMessage(
                  message: messageController.text,
                  subject: subjectController.text,
                  stateId: heirarchyProvider.stateDropDownValue,
                  districtId: heirarchyProvider.districtDropdownValue,
                  constituencyId: heirarchyProvider.constituencyDropdownValue,
                  panchayathId: heirarchyProvider.panchayathDropdownValue,
                  unitId: heirarchyProvider.unitDropdownValue,
                  recipientId: recipientDropdownValue == "Select Member"
                      ? null
                      : recipientDropdownValue.id,
                );
                Navigator.pop(context);
                showSnackbar(
                    context: context, text: "Message send Successfully");
              },
              icon: const Icon(
                Icons.send_outlined,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeirarchyFilttering(
                    all: true,
                    filterCallBack: () {
                      memberProvider.getMembers(
                        memberType: "member",
                        stateId: heirarchyProvider.stateDropDownValue,
                        districtId: heirarchyProvider.districtDropdownValue,
                        panchayathId: heirarchyProvider.panchayathDropdownValue,
                        unitId: heirarchyProvider.unitDropdownValue,
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 5,
                    ),
                    child: Text(
                      "Select Recipient",
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
                          child: DropdownButton<dynamic>(
                            dropdownColor: const Color(0xFFFFFFFF),
                            value: recipientDropdownValue,
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            elevation: 16,
                            style: const TextStyle(
                                color: primaryGreyColor,
                                fontWeight: FontWeight.w500),
                            onChanged: (dynamic newValue) {
                              if (newValue != 'Select Member') {
                                setState(() {
                                  recipientDropdownValue = newValue;
                                });
                              }
                            },
                            items: [
                              'Select Member',
                              ...memberProvider.members
                            ].map<DropdownMenuItem<dynamic>>((dynamic value) {
                              if (value is String) {
                                return DropdownMenuItem<dynamic>(
                                  value: value,
                                  child: Text(value),
                                );
                              } else {
                                return DropdownMenuItem<dynamic>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Subject",
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
                        border: Border.all(
                          color: borderGrayColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                            controller: subjectController,
                            decoration: const InputDecoration(
                              hintText: "subject",
                              border: InputBorder.none,
                            )),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Message",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
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
                          enabled: true,
                          controller: messageController,
                          cursorColor: primaryGreen,
                          onChanged: (String? value) {},
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "  Messgae"),
                          minLines: 6,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Message";
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  // for (int i = 0; i < attachments.length; i++)
                  if (attachment != null)
                    GestureDetector(
                      onTap: () {
                        OpenFilex.open(attachment!.path);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffEEEEEE),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      attachment!.path.split("/").last)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  attachment = null;
                                });
                              },
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
