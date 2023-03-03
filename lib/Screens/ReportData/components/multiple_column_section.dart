import 'package:flutter/material.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/ReportData/components/single_column_field.dart';

class MultipleColumnSection extends StatefulWidget {
  Function(String key, String? value) onChange;
  String male, female, total;
  MultipleColumnSection({
    this.male = "",
    this.female = "",
    this.total = "",
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  State<MultipleColumnSection> createState() => _MultipleColumnSectionState();
}

class _MultipleColumnSectionState extends State<MultipleColumnSection> {
  int total = 0;

  String male = "0";
  String female = "0";

  @override
  void initState() {
    super.initState();
    setState(() {
      total = widget.total != "" ? int.parse(widget.total) : 0;
    });
  }

  _calculateTotal() {
    setState(() {
      total = int.parse(
            male != "" ? male : "0",
          ) +
          int.parse(
            female != "" ? female : "0",
          );

      widget.onChange('total', total.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SingleColumnField(
          title: 'Male',
          value: widget.male,
          onChange: (String? txt) {
            widget.onChange('male', txt);
            setState(() {
              male = txt.toString();
              _calculateTotal();
            });
          },
        ),
        SingleColumnField(
          title: 'Female',
          value: widget.female,
          onChange: (String? txt) {
            widget.onChange('female', txt);
            setState(() {
              female = txt.toString();
              _calculateTotal();
            });
          },
        ),

        // SingleColumnField(
        //   title: 'Total',
        //   value: widget.total,
        //   onChange: (String? txt) {
        //     widget.onChange('total', txt);
        //   },
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: SizedBox(
            width: 100,
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    total.toString(),
                    style: const TextStyle(fontSize: 17),
                  )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
