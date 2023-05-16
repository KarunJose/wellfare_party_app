import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/providers/unit_provider.dart';

class UnitList extends StatelessWidget {
  const UnitList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, unitProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Unit List'),
            backgroundColor: Colors.red,
          ),
           body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        for(var unit in unitProvider.unitList)
                        ListTile(title: Text(unit.unitName)),
                      ],
                    ),
                  ),
        );
      }
    );
  }
}