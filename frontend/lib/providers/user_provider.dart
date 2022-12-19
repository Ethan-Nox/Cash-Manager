import 'package:flutter/foundation.dart';
import 'package:frontend/models/user.dart';

class UserProvider extends ChangeNotifier {
  // ignore: avoid_init_to_null
  late User? currentUser = null;
  // User? get currentUser => currentUser;

  late List oldInfos = [];

  late String oldUSer = "";
  late String oldPassword = "";

  void setCurrentUser(User? user) {
    currentUser = user;
    print(currentUser!.firstName);
    notifyListeners();
  }

  void resetCurrentUSer() {
    currentUser = null;
    notifyListeners();
  }

  User getUser() {
    return currentUser!;
  }

  void setOldInfos(List infos) {
    oldInfos = infos;
    notifyListeners();
  }

  List getOldInfos() {
    return oldInfos;
  }

  void setOldUser(String user) {
    oldUSer = user;
    notifyListeners();
  }

  String getOldUser() {
    return oldUSer;
  }

  void setOldPassword(String password) {
    oldPassword = password;
    notifyListeners();
  }

  String getOldPassword() {
    return oldPassword;
  }
}
