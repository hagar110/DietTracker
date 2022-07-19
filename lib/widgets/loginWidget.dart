import 'package:flutter/material.dart';

import '../globals/globalVariables.dart';
import '../globals/globalwidgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        defaultTextForm(controller: emailController, text: 'email'),
        SizedBox(
          height: 10,
        ),
        passwordDefaultTextFiled(provider.showloginPassword, 'password',
            passwordController, 2, passwordController)
        //passwordDefaultTextFiled('password', passwordValidator),
      ],
    );
  }
}
