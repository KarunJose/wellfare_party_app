import 'package:flutter/material.dart';

class OfficeList extends StatelessWidget {
  const OfficeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: const SafeArea(
        child: Center(
          child: Text('No data available'),
        ),
      ),
    );
  }
}