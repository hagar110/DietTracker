import 'package:flutter/cupertino.dart';

class buttonProvider extends ChangeNotifier {
  bool checkOutshowProgressIndicator = false;
  void togglecheckOutProgressIndicator() {
    checkOutshowProgressIndicator = !checkOutshowProgressIndicator;
    notifyListeners();
  }

  bool checkinshowProgressIndicator = false;
  void togglecheckinProgressIndicator() {
    checkinshowProgressIndicator = !checkinshowProgressIndicator;
    notifyListeners();
  }

  bool signinOrsignupshowProgressIndicator = false;
  void togglesigninOrsignupProgressIndicator() {
    signinOrsignupshowProgressIndicator = !signinOrsignupshowProgressIndicator;
    notifyListeners();
  }
}
