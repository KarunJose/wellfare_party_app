import 'package:flutter/material.dart';

showSnackbar({required context, required String text}) {
  var snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(text.toString()),
    // duration: Duration(seconds: ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
