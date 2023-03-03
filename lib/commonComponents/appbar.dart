import 'package:flutter/material.dart';

Widget getAppbar(String pageId) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.sync)),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_outlined),
      ),
    ],
  );
}
