import 'dart:convert';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/globals/globalFunctions.dart';

import 'diet.dart';
import 'doctor.dart';
import 'inbody.dart';
import 'user.dart';

class patient extends user {
  late inbody Inbody;
  late doctor? Doctor;
  late diet Diet;
  late int Age;
  late String Case;

  patient.empty() : super.empty();

  patient(String uId, String username, String email, String password,
      String Gender, int age, String c, String image)
      : Age = age,
        Case = c,
        super.withnames(uId, username, email, password, Gender, image);

  factory patient.fromJson(dynamic json) {
    return patient(
        json["_id"],
        json["username"],
        json["email"],
        json["password"],
        json["gender"],
        json["age"],
        json["case"],
        json["image"]);
  }

  @override
  Future<int?> register() async {
    Inbody = currentInbody;
    print("register" + Inbody.BMI.toString());
    final response = await dio.post(GlobalUrl + "patientRegister",
        data: json.encode(<String, dynamic>{
          "username": username.trim(),
          "email": email.trim(),
          "password": password.trim(),
          "gender": Gender,
          "age": Age,
          "Case": Case,
          "height": Inbody.height,
          "weight": Inbody.weight,
          "BMI": Inbody.BMI,
        }));
    if (response.statusCode == 200 && response.statusMessage == 'OK') {
      uId = currentuser.uId = currentpatient.uId = uId.trim();

      return response.statusCode;
    } else {
      throw Exception('failed to register' + response.statusMessage!);
    }
  }
}
