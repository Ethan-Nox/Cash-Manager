import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int _selectedIndex = 1;

  void changePage(int index) {
    _selectedIndex = index;
    notifyListeners();
    // return _selectedIndex;
  }

  int getPage() {
    return _selectedIndex;
  }
}
