import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'globalVariables.dart';

Widget signUPorLogin(
        context, GlobalKey<FormState> _formKey, Function submit, String text) =>
    Column(
      children: [
        !button_provider.signinOrsignupshowProgressIndicator
            ? SizedBox(
                width: 250,
                child: ElevatedButton(
                  child: Text(text),
                  onPressed: () => {
                    button_provider.togglesigninOrsignupProgressIndicator(),
                    if (!_formKey.currentState!.validate())
                      {
                        button_provider.togglesigninOrsignupProgressIndicator(),
                        print("invalidddd"),
                      }
                    else
                      {_formKey.currentState!.save(), submit(context)}
                  },
                ))
            : CircularProgressIndicator(),
        Divider(
          color: Colors.grey[350],
        ),
        loginOrRegisterButton(
            (text == 'sign in' ? 'sign up' : 'sign in') + ' instead')
      ],
    );
void showToast(bool success, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: success ? Colors.green[500] : Colors.red,
      textColor: Colors.white);
}

Widget loginOrRegisterButton(String title) => SizedBox(
      height: 35,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () {
            provider.toggleisLogin();
          },
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
Widget defaultTextForm(
        {Function? onsaved,
        required TextEditingController controller,
        required String text}) =>
    TextFormField(
      decoration: InputDecoration(
          labelText: text,
          labelStyle:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.green[500]!.withOpacity(1), width: 3),
          )),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Invalid $text!';
        } else if (text == "email") {
          bool emailValid = RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value);
          print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh' + emailValid.toString());
          if (!emailValid) return 'invalid email';
        }
        print("in validatorrr");
        return null;
      },
      onSaved: (value) {
        authData[text] = value!;
      },
    );

Widget passwordDefaultTextFiled(
        bool showpass,
        String text,
        TextEditingController controller,
        int passType,
        TextEditingController? compareController) =>
    TextFormField(
      obscureText: !showpass,
      decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(Icons.security),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
              ),
              color: showpass ? Colors.green[500] : Colors.grey,
              onPressed: () => {
                    if (passType == 0)
                      {provider.togglePassword()}
                    else if (passType == 1)
                      {provider.toggleConfirmPassword()}
                    else
                      {provider.toggleLoginPassword()}
                  }),
          labelStyle:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.green[500]!.withOpacity(1), width: 3),
          )),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) return 'Invalid password';
        if (passType == 1) {
          if (value != compareController!.text) {
            return 'password does not match!';
          }
        }
        return null;
      },
      onSaved: (value) {
        authData[text] = value!;
      },
    );
