import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../MainConst/main_const.dart';

class MemberBox extends StatelessWidget {
  String title;
  String count;
  bool isLoading;
  MemberBox({
    required this.title,
    required this.count,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 50,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 40,
              width: 155,
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: textGreenColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: Colors.grey.shade200),
                  ],
                  border: Border.all(color: primaryGreen, width: 3),
                  shape: BoxShape.circle,
                  color: Colors.white),
              child: Center(
                child: isLoading == true
                    ? SpinKitWave(
                        color: primaryGreen,
                        size: 15.0,
                      )
                    : Text(
                        count,
                        style: const TextStyle(
                            color: primaryGreyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
