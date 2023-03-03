import 'package:flutter/material.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/models/member_model.dart';
import 'package:wellfare_party_app/models/officebearer_list_model.dart';

class BearerCard extends StatelessWidget {
  OfficeBearerListModel bearerList;
  BearerCard({
    required this.bearerList,
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
          color: Colors.grey.shade50,
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
                children: [
                  Text(
                    bearerList.memberName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    bearerList.memberType,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    bearerList.mobile,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bearerList.designationName,
                    style: const TextStyle(
                        fontSize: 13,
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
                              color: bearerList.status == "0"
                                  ? Colors.red
                                  : textGreenColor,
                              shape: BoxShape.circle),
                        ),
                        Text(
                          bearerList.status == "0" ? "Inactive" : "Active",
                          style: const TextStyle(
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
