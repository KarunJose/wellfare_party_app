import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/member_list/member_list_screen.dart';
import 'package:wellfare_party_app/providers/member_provider.dart';

class MemberCountSection extends StatelessWidget {
  const MemberCountSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvder>(
      builder: (context, memberProvider, child) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xffF4F4F4),
          ),
          child: Row(
            children: [
              Container(
                width: (MediaQuery.of(context).size.width / 2) - 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Members",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => MemberListScreen(
                                    memberType: "member", gender: "male"),
                              ),
                            );
                          },
                          child: GenderCount(
                            title: memberProvider.maleMembersCount.toString(),
                            icon: "assets/icons/svgicons/male.svg",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => MemberListScreen(
                                    memberType: "member", gender: "female"),
                              ),
                            );
                          },
                          child: GenderCount(
                            title: memberProvider.femaleMembersCount.toString(),
                            icon: "assets/icons/svgicons/female.svg",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => MemberListScreen(
                                    memberType: "member", gender: ""),
                              ),
                            );
                          },
                          child: GenderCount(
                            title: memberProvider.totalMemberCount.toString(),
                            icon: "assets/icons/svgicons/total.svg",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: double.infinity,
                width: 1,
                color: Color(0xffDDDDDD),
              ),
              Container(
                width: (MediaQuery.of(context).size.width / 2) - 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Primary Members",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => MemberListScreen(
                                    memberType: "primarymember",
                                    gender: "male"),
                              ),
                            );
                          },
                          child: GenderCount(
                            title: memberProvider.malePrimaryMembersCount
                                .toString(),
                            icon: "assets/icons/svgicons/male.svg",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => MemberListScreen(
                                    memberType: "primarymember",
                                    gender: "female"),
                              ),
                            );
                          },
                          child: GenderCount(
                            title: memberProvider.femalePrimaryMembersCount
                                .toString(),
                            icon: "assets/icons/svgicons/female.svg",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => MemberListScreen(
                                    memberType: "primarymember", gender: ""),
                              ),
                            );
                          },
                          child: GenderCount(
                            title: memberProvider.totalPrimaryMembersCount
                                .toString(),
                            icon: "assets/icons/svgicons/total.svg",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderCount extends StatelessWidget {
  String title;
  String icon;
  GenderCount({
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // ignore: sort_child_properties_last
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              icon,
            ),
          ),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xff212121)),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(title),
      ],
    );
  }
}
