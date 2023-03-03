import 'package:flutter/material.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/models/loginUserModel.dart';

class AppAdminCard extends StatelessWidget {
  LoginUserModel loginuserList;
  AppAdminCard({
    required this.loginuserList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Color(0XFFF9F9F9),
          color: Colors.grey.shade100,
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
                  Text(
                    // bearerList.memberName,
                    loginuserList.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    // bearerList.memberType,
                    loginuserList.memberType,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    // bearerList.mobile,
                    loginuserList.phone,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loginuserList.roleName,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF4D4D4D)),
                  ),
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
                              color: loginuserList.status == "0"
                                  ? Colors.red
                                  : textGreenColor,
                              shape: BoxShape.circle),
                        ),
                        Text(
                          loginuserList.status == "0" ? "Inactive" : "Active",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
