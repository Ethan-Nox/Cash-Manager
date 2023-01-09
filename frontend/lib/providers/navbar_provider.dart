import 'package:flutter/material.dart';
class NavBarProvider extends ChangeNotifier {
  late int _currentPageIndex = 1;
  int get currentPageIndex => _currentPageIndex;

  void changePage(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  int getPage() {
    return _currentPageIndex;
  }
}
