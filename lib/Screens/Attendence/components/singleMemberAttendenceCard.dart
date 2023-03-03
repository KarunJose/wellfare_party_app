import 'package:flutter/material.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/models/member_model.dart';

class SingleMemberAttendenceCard extends StatefulWidget {
  Function(Member, String) selectedAttendenceValue;

  Member member;
  SingleMemberAttendenceCard({
    required this.member,
    required this.selectedAttendenceValue,
    Key? key,
  }) : super(key: key);

  @override
  State<SingleMemberAttendenceCard> createState() =>
      _SingleMemberAttendenceCardState();
}

class _SingleMemberAttendenceCardState
    extends State<SingleMemberAttendenceCard> {
  String attendencevalue = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.7,
                child: Text(
                  widget.member.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              // const Text(
              //   "Member",
              //   style: TextStyle(fontWeight: FontWeight.w300),
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 40,
                  child: Radio(
                      activeColor: textGreenColor,
                      value: "Present",
                      groupValue: attendencevalue,
                      onChanged: (String? val) {
                        widget.selectedAttendenceValue(widget.member, val!);
                        setState(() {
                          attendencevalue = val;
                        });
                      }),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 80,
                  child: Radio(
                      value: "Absent",
                      activeColor: Color(0XFFEE9A1D),
                      groupValue: attendencevalue,
                      onChanged: (String? val) {
                        widget.selectedAttendenceValue(widget.member, val!);
                        setState(() {
                          attendencevalue = val;
                        });
                      }),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 40,
                  child: Radio(
                      activeColor: Color(0xffDA251C),
                      value: "Leave",
                      groupValue: attendencevalue,
                      onChanged: (String? val) {
                        widget.selectedAttendenceValue(widget.member, val!);
                        setState(() {
                          attendencevalue = val;
                        });
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
