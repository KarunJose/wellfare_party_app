import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/providers/panchayat_provider.dart';

class PanchayatList extends StatelessWidget {
  const PanchayatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PanchayatProvider>(
      builder: (context, panchayatProvider, child) {
        return Scaffold(
              appBar: AppBar(
                title: const Text("Panchayath List"),
                backgroundColor: Colors.red,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    for(var panchayat in panchayatProvider.panchayatList)
                    ListTile(title: Text(panchayat.panchayathName)),
                  ],
                ),
              ),
            );
      }
    );
  }
}