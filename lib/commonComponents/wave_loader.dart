import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';

class WaveLoader extends StatelessWidget {
  const WaveLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.white.withOpacity(0.7),
      child: const Center(
          child: SpinKitWave(
        color: primaryGreen,
        size: 20.0,
      )),
    );
  }
}
