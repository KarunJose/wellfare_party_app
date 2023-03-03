import 'package:flutter/material.dart';
import 'package:wellfare_party_app/models/qustionnaire_model.dart';

class DipartmentSection extends StatelessWidget {
  String title;
  String dipCode;
  bool selected;
  DipartmentSection({
    required this.title,
    required this.dipCode,
    this.selected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Colors.blue : Colors.grey,
          ),
          child: Center(
              child: Text(
            dipCode,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          )),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 60,
          child: Text(title),
        )
      ],
    );
  }
}
