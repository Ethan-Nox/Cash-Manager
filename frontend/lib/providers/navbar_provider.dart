import 'package:flutter/material.dart';

class NavBarProvider extends ChangeNotifier {
  late int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void changePage(int index) {
    _currentPageIndex = index;
    notifyListeners();
    // return _currentPageIndex;
  }

  int getPage() {
    return _currentPageIndex;
  }
}
