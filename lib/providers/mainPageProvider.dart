import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class mainProvider extends ChangeNotifier {
  bool isLogin = true;
  void toggleisLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  void getusers() {
    // http://192.168.56.1:6666/api/
    //192.168.1.60:6666
  }
  bool showPassword = false;
  void togglePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  bool showConfirmPassword = false;
  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  bool showloginPassword = false;
  void toggleLoginPassword() {
    showloginPassword = !showloginPassword;
    notifyListeners();
  }
}
