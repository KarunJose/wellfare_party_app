import 'package:flutter/material.dart';

import '../../../MainConst/main_const.dart';

class SingleColumnField extends StatefulWidget {
  String title;
  bool textfield;
  String value;
  Function(String?) onChange;
  SingleColumnField({
    required this.title,
    this.textfield = false,
    required this.onChange,
    this.value = "",
    Key? key,
  }) : super(key: key);

  @override
  State<SingleColumnField> createState() => _SingleColumnFieldState();
}

class _SingleColumnFieldState extends State<SingleColumnField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.textfield == true) {
      // TextFormField
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: borderGrayColor,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              enabled: true,
              controller: _controller,
              cursorColor: primaryGreen,
              onChanged: widget.onChange,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "  Type here"),
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        ),
      );
    } else {
      // Normal Textfield
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: SizedBox(
          width: 100,
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    onChanged: widget.onChange,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
