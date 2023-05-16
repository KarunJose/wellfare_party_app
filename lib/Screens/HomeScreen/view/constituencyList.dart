import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/providers/constituencyList_provider.dart';

class ConstituencyDetailScreen extends StatelessWidget {
  const ConstituencyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConstituencyProvider>(
      builder: (context, constituencyProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Constituecy List"),
            backgroundColor: Colors.red,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                for(var constituency in constituencyProvider.constituencyList)
                ListTile(title: Text(constituency.constituencyName)),
              ],
            ),
          ),
        );
      }
    );
  }
}