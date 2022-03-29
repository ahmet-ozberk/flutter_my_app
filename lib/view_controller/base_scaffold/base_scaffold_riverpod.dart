import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScaffoldRiverpod extends ChangeNotifier {
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.text_quote), label: "blog",),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.doc_text_search), label: "task"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.doc_text), label: "flutter"),
  ];
  int currentIndex = 0;
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  String appBarTitle() {
    switch (currentIndex) {
      case 0:
        return "Blog";
      case 1:
        return "Task";
      case 2:
        return "Flutter Notlar";
      default:
        return "";
    }
  }

  double appBarTitleShadow() {
    switch (currentIndex) {
      case 0:
        return -10;
      case 1:
        return 0;
      case 2:
        return 10;
      default:
        return 0.0;
    }
  }

  Color appBarTitleColor() {
    switch (currentIndex) {
      case 0:
        return Colors.red.withOpacity(0.1);
      case 1:
        return Colors.green.withOpacity(0.1);
      case 2:
        return Colors.blue.withOpacity(0.1);
      default:
        return Colors.blue.withOpacity(0.1);
    }
  }
    Color bottomBarTitleColor() {
    switch (currentIndex) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }
}
