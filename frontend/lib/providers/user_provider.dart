import 'package:flutter/foundation.dart';
import 'package:frontend/models/user.dart';

class UserProvider extends ChangeNotifier {
  // ignore: avoid_init_to_null
  late User? currentUser = null;
  // User? get currentUser => currentUser;

  void setCurrentUser(User? user) {
    currentUser = user;
    notifyListeners();
  }

  User getUser() {
    return currentUser!;
  }
}
