import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/MemberManagement/member_card.dart';
import 'package:wellfare_party_app/commonComponents/myLoader.dart';
import 'package:wellfare_party_app/models/member_model.dart';

import '../../providers/member_provider.dart';

class MemberListScreen extends StatefulWidget {
  String memberType;
  String gender;
  MemberListScreen({required this.memberType, required this.gender, Key? key})
      : super(key: key);

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
    super.initState();
  }

  _getInitialDetails() async {
    await Provider.of<MemberProvder>(context, listen: false)
        .getMembers(memberType: widget.memberType, gender: widget.gender);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvder>(
      builder: (context, memberProvider, child) => Scaffold(
        appBar: AppBar(
            title: Text(widget.gender == "male"
                ? " Male Members"
                : widget.gender == "female"
                    ? "Female Members"
                    : "Total Members")),
        body: Consumer<MemberProvder>(
          builder: (context, memberProvider, child) => ListView(
            children: [
              if (memberProvider.loading)
                Center(child: const MyLoader())
              else
                for (Member member in widget.memberType == "member"
                    ? memberProvider.members
                    : memberProvider.primaryMembers)
                  MemberCard(member: member, show: true),
              if (memberProvider.loading == false)
                if ((widget.memberType == "member" &&
                        memberProvider.members.isEmpty) ||
                    (widget.memberType == "primarymember" &&
                        memberProvider.primaryMembers.isEmpty))
                  const Center(child: Text("No members"))
            ],
          ),
        ),
      ),
    );
  }
}
