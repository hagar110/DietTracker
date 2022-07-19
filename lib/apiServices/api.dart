import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstgp/globals/globalwidgets.dart';

import 'package:firstgp/models/doctor.dart';
import 'package:firstgp/models/inbody.dart';
import 'package:firstgp/models/patient.dart';
import 'package:firstgp/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';

import '../globals/globalVariables.dart';

class apiServices {
  String doctorsurl = GlobalUrl + "getdoctors";
  String patienturl = GlobalUrl + "getpatient/";
  String patientDoctorurl = GlobalUrl + "getpatientdoctor/";
  String doctorurl = GlobalUrl + "getdoctor/";
  String inbodyurl = GlobalUrl + "getinbody/";
  String decScore = GlobalUrl + "decreaseScore";
  String incScore = GlobalUrl + "increaseScore";
  String getDiet = GlobalUrl + "getdiet/";

  Dio dio = new Dio();

  Future<void> increaseScore(String docId) async {
    final response = await dio.put(incScore,
        data: json.encode(<String, dynamic>{
          "_id": docId,
        }));
    if (response.statusCode == 200) {
      showToast(true, 'your feedback is recorded successfuly');
    } else {
      throw Exception('failed to record the feedback');
    }
  }

  Future<void> decreaseScore(String docId) async {
    final response = await dio.put(decScore,
        data: json.encode(<String, dynamic>{
          "_id": docId,
        }));
    if (response.statusCode == 200) {
      showToast(true, 'your feedback is recorded successfuly');
    } else {
      throw Exception('failed to record the feedback');
    }
  }

  /* Future<int> getPatientDiet() async {
    final response = await dio.get(
      getDiet + currentuser.uId,
    );
    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['diet'].toString() +
          "                   ");
      currentdoctor = doctor.fromJson(response.data['diet']);
      return response.statusCode!;
    } else {
      throw Exception('failed to get doctor');
    }
  }
*/
  Future<void> logmeal(String mealtype, double calories, String meal) async {
    debugPrint(GlobalUrl + 'logameal');
    try {
      final response = await dio.put(GlobalUrl + 'logameal',
          data: json.encode(<String, dynamic>{
            "_id": uId,
            "meal": mealtype,
            "breakfast": meal,
            "lunch": meal,
            "dinner": meal,
            "snacks": meal,
            "breakfastCalories": calories,
            "lunchCalories": calories,
            "dinnerCalories": calories,
            "snacksCalories": calories
          }));
      if (response.statusCode == 200) {
        showToast(true, 'meal logged successfully');
      } else {
        showToast(false, 'failed to log the meal');
        throw Exception('failed to log the meal');
      }
    } on DioError catch (e) {
      /* if (e.response!.statusCode == 404) {
        print(e.response!.statusCode);
      } else {
        print(e.message);
        // print(e.request);
      }
*/
      showToast(false, 'failed to log the meal');
    }
  }

  Future<void> unsubscribeAdoctor(String docId) async {
    debugPrint(GlobalUrl + 'unsubscribeAdoctor');
    debugPrint(docId);
    final response = await dio.put(GlobalUrl + 'unsubscribeAdoctor',
        data: json.encode(<String, dynamic>{
          "patientid": currentuser.uId,
          "doctorid": docId,
        }));
    if (response.statusCode == 200) {
      currentpatient.Doctor = null;
      currentPatientDoctor = null;
      showToast(true, 'you unsubscribed the doctor successfuly');
    } else {
      throw Exception('failed to unsubscribe the doctor');
    }
  }

  Future<void> registerAdoctor(String docId, doctor doc) async {
    debugPrint(GlobalUrl + 'subscribeAdoctor');
    debugPrint(docId);
    final response = await dio.put(GlobalUrl + 'subscribeAdoctor',
        data: json.encode(<String, dynamic>{
          "patientid": currentuser.uId,
          "doctorid": docId,
        }));
    if (response.statusCode == 200) {
      currentpatient.Doctor = doc;
      currentPatientDoctor = doc;
      showToast(true, 'you subscribed the doctor successfuly');
    } else {
      throw Exception('failed to subscribe the doctor');
    }
  }

  Future<num?> getDoctor(String uId) async {
    print("in get doctor take care");
    final response = await dio.get(
      doctorurl + uId,
    );

    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['doctor'].toString() +
          "                   ");

      currentdoctor = doctor.fromJson(response.data['doctor']);
      currentdoctor.newsfeed =
          response.data['doctor']["newsfeed"].cast<String>();
      currentdoctor.newsfeed = currentdoctor.newsfeed.reversed.toList();
      debugPrint("dodo :  " + currentdoctor.newsfeed.toString());
      return response.statusCode;
    } else {
      throw Exception('failed to get doctor');
    }
  }

  Future<int?> getdoctors() async {
    print("ibvgfgdyshdy");
    final response = await dio.get(
      doctorsurl,
    );
    if (response.statusCode == 200) {
      print("dkdjdd");
      doctors = (response.data['doctors'] as List)
          .map((data) => doctor.fromJson(data))
          .toList();
      /*for (int i = 0; i < doctors.length; i++) {
        print("before " +
            doctors[i].username +
            " " +
            doctors[i].ratingScore.toString() +
            "\n");
      }*/
      doctors.sort((a, b) => b.ratingScore.compareTo(a.ratingScore));
      for (int i = 0; i < doctors.length; i++) {
        doctors[i].ratingScore=(doctors[i].ratingScore/doctors[0].ratingScore)*5;
        print("after " +
            doctors[i].username +
            " " +
            doctors[i].ratingScore.toString() +
            "\n");
      }
      return response.statusCode;
    } else {
      throw Exception('failed to get doctors');
    }
  }

  Future<num?> getInbody(String uId) async {
    final response = await dio.get(
      inbodyurl + uId,
    );

    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['inbody'].toString() +
          "                   ");

      currentInbody = inbody.fromJson(response.data['inbody']);

      return response.statusCode;
    } else {
      throw Exception('failed to get inbody');
    }
  }

  Future<num?> getPatientDoctor(String uId) async {
    final response = await dio.get(
      patientDoctorurl + uId,
    );

    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeDoctor" +
          response.data['doctor'].toString() +
          "                   ");

      currentPatientDoctor = (response.data['doctor'] != null)
          ? doctor.fromJson(response.data['doctor'])
          : null;

      return response.statusCode;
    } else {
      throw Exception('failed to get patient doctor');
    }
  }

  Future<num?> getpatient(String uId) async {
    final response = await dio.get(
      patienturl + uId,
    );

    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['patient'].toString() +
          "                   ");

      currentpatient = patient.fromJson(response.data['patient']);

      return response.statusCode;
    } else {
      throw Exception('failed to get patient');
    }
  }
}
