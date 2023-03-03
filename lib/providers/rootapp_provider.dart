import 'dart:io';

import 'package:flutter/material.dart';

import '../Screens/HomeScreen/homeTab.dart';
import '../Screens/Root_app/root_app.dart';
import '../commonComponents/confirmationBox/confirmationBox.dart';

class RootAppProvider extends ChangeNotifier {
  String pageId = HomeTab.id;

  List<String> routeStack = [];

  selectTab(String id) {
    pageId = id;
    if (routeStack.isNotEmpty) {
      if (routeStack.last == pageId) {
        return;
      }
    }
    routeStack.add(id);
    notifyListeners();
  }

  goBack(context) {
    // pageId = HomeTab.id;

    if (routeStack.isNotEmpty) {
      routeStack.removeLast();
      if (routeStack.isEmpty) {
        pageId = HomeTab.id;
      } else {
        pageId = routeStack[routeStack.length - 1];
      }
    } else {
      // Ask if exit
      ConfirmationBox(
        context: context,
        title: "Exit",
        body: "Are you sure?",
        confirmFunction: () {
          exit(0);
        },
      );
    }

    notifyListeners();
  }

  clearAllandGoHome(context) {
    routeStack = [];
    pageId = HomeTab.id;
    // notifyListeners();
    Navigator.pushNamedAndRemoveUntil(context, RootApp.id, (route) => false);
  }
}
