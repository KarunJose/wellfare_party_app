import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: primaryGreen,
      size: 50.0,
    );
  }
}
