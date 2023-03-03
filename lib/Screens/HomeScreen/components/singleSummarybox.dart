import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleSummaryBox extends StatelessWidget {
  String title;
  String icon;
  String count;
  SingleSummaryBox({
    required this.title,
    required this.icon,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xffEEEEEE),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: SvgPicture.asset(icon),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title),
          const SizedBox(
            height: 5,
          ),
          Text(count),
        ],
      ),
    );
  }
}
