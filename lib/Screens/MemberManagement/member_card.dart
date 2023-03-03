import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/AddMemberScreen/add_member_screen.dart';
import 'package:wellfare_party_app/models/member_model.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

class MemberCard extends StatefulWidget {
  Member member;
  bool show;
  MemberCard({
    required this.member,
    required this.show,
    Key? key,
  }) : super(key: key);

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  String certificateURL = "$baseUrl/api/Members/membership_certificate/";
  void _downloadCertificate(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      showSnackbar(
        context: context,
        text: "Failed",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Color(0XFFF9F9F9),
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.member.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (widget.show == false)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => AddMemberScreen(
                                  edit: true,
                                  member: widget.member,
                                  show: widget.show,
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Colors.grey,
                          ),
                        )
                    ],
                  ),
                  Text(
                    widget.member.memberType,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.member.mobile,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 67,
                    height: 20,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.5, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: widget.member.status == "0"
                                  ? Colors.red
                                  : textGreenColor,
                              shape: BoxShape.circle),
                        ),
                        Text(
                          widget.member.status == "0" ? "Inactive" : "Active",
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  widget.show == false
                      ? GestureDetector(
                          onTap: () {
                            _downloadCertificate(
                                certificateURL + widget.member.id);
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: Text(
                                "Certificate",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
