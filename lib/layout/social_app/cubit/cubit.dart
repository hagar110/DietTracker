import 'dart:convert';

import 'dart:io';

import 'package:firstgp/modules/social_app/patients/patients_screen.dart';
import 'package:firstgp/modules/social_app/feeds/doctor_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firstgp/models/dish/meal_model.dart';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/cubit/states.dart';
import 'package:firstgp/models/patient.dart';
import 'package:firstgp/models/history.dart';
import 'package:firstgp/models/social_app/chat_model.dart';

import 'package:firstgp/modules/social_app/chats/chats_screen.dart';
import 'package:firstgp/modules/social_app/feeds/feeds_screen.dart';
import 'package:firstgp/modules/social_app/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../screens/doctorsScreen.dart';
import '../../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {

  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  String getMeals = GlobalUrl + "getTodaymeal/";
  String incrementCounter = GlobalUrl + "incrementMealCounter/";


  int currentIndex = 0;
  List<Widget> screens = [];
  List<String> titles = [];

  void setScreens() {
    screens = [
      isDoctor ? DoctorHome() : FeedsScreen(),
      ChatsScreen(),
      isDoctor ? PatientsScreen() : doctorsScreen(),
      SettingsScreen()
    ];
    titles = [
      'News Feed',
      'Chats',
      (!isDoctor) ? 'Doctors' : "Patients",
      'Settings'
    ];
  }

  void ChangeBottomNav(int index) async {
    if (index == 1 || index == 2) {
      if (isDoctor) {
        await getDoctorPatients();
        receivers = [];
        images = [];
        names = [];
        for (int i = 0; i < doctorPatients.length; i++) {
          receivers.add(doctorPatients[i].uId);
          names.add(doctorPatients[i].username);
          images.add(doctorPatients[i].image);
        }
      } else {
        await getPatientsOfSameCase();
      }
    }
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage({
    required String name,
    required int age,
    required num price,
    required String clinicPhone,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        currentuser.image = value;
        updateUserProfile(
            name: name,
            image: value,
            age: age,
            price: price,
            clinicPhone: clinicPhone);
        profileImage = null;
      }).catchError((error) {});
      emit(SocialUploadProfileImageErrorState());
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error);
    });
  }

  Dio dio = new Dio();

  Future<int?> updateUserProfile(
      {required String name,
      required int age,
      required num price,
      required String clinicPhone,
      String? image}) async {
    emit(SocialUserUpdateLoadingState());

    if (isDoctor) {
      final response = await dio.put(GlobalUrl + "updatedoctor",
          data: json.encode(<String, dynamic>{
            "_id": currentuser.uId,
            "username": name,
            "price": price,
            "clinicPhone": clinicPhone,
            "image": image ?? currentdoctor.image,
          }));
      if (response.statusCode == 200 && response.statusMessage == 'OK') {
        print("Doctor updated successfully");
        currentdoctor.image = image ?? currentdoctor.image;
        currentuser.image = image ?? currentdoctor.image;
        currentdoctor.username = name;
        currentdoctor.price = price;
        currentdoctor.cliniquePhone = clinicPhone;

        emit(SocialUserUpdateSuccessState());
        return response.statusCode;
      } else {
        throw Exception('failed to update doctor' + response.statusMessage!);
      }
    } else {
      final response = await dio.put(GlobalUrl + "updatepatient",
          data: json.encode(<String, dynamic>{
            "_id": currentuser.uId,
            "username": name,
            "age": age,
            "Case": currentpatient.Case,
            "image": image ?? currentpatient.image,
          }));
      if (response.statusCode == 200 && response.statusMessage == 'OK') {
        print("Patient updated successfully");
        currentpatient.image = image ?? currentpatient.image;
        currentuser.image = image ?? currentpatient.image;
        currentpatient.username = name;
        currentpatient.Age = age;

        emit(SocialUserUpdateSuccessState());
        return response.statusCode;
      } else {
        throw Exception('failed to update patient' + response.statusMessage!);
      }
    }
  }

  Future<int?> updateUserInBody(
      {required double height,
      required double weight,
      required num PBF,
      required num PBW}) async {
    emit(SocialUserUpdateLoadingState());
    print("entered inbody update");
    print(height.toString() +
        " " +
        weight.toString() +
        " " +
        PBF.toString() +
        " " +
        PBW.toString());
    final response = await dio.put(GlobalUrl + "updateinbody",
        data: json.encode(<String, dynamic>{
          "_id": currentuser.uId,
          "height": height,
          "weight": weight,
          "BMI": weight / (height / 100.0),
          "PBF": PBF,
          "PBW": PBW,
        }));
    if (response.statusCode == 200 && response.statusMessage == 'OK') {
      print("Patient updated successfully");
      currentInbody.height = height;
      currentInbody.weight = weight;
      currentInbody.BMI = weight / (height / 100.0);
      currentInbody.PBF = PBF;
      currentInbody.PBW = PBW;
      emit(SocialUserUpdateSuccessState());
      return response.statusCode;
    } else {
      throw Exception(
          'failed to update patient inbody' + response.statusMessage!);
    }
  }

  Future<void> getdoctors() async {
    await api.getdoctors();
  }

  Future<int?> getPatientsOfSameCase() async {
    patientsOfSameCase = [];

    final response = await dio.get(
      GlobalUrl + "getpatients",
    );

    if (response.statusCode == 200) {
      patients = (response.data['patients'] as List)
          .map((data) => patient.fromJson(data))
          .toList();

      //returning patients of same case for chatroom
      for (int i = 0; i < patients.length; i++) {
        if (patients[i].Case == currentpatient.Case &&
            patients[i].uId != currentpatient.uId) {
          print(
              "^^^^^^^^^^^^^^^^^^" + currentuser.uId + "  " + patients[i].uId);
          patientsOfSameCase.add(patients[i]);
        }
        emit(SocialGetAllUsersSuccessState());
      }
      return response.statusCode;
    } else {
      throw Exception('failed to get patients');
    }
  }

  Future<void> getPatientMeals() async {
    final response = await dio.get(
      getMeals + uId,
    );
    print(response);
    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['diet'].toString() +
          "                   ");
      patientmeal = meal.fromJson(response.data['diet']);
    } else {
      throw Exception('failed to get meal');
    }
  }

  Future<void> getPatientLoggedMeals(uId) async {
    print("444444444444444");
    final response = await dio.get(
      GlobalUrl + "getdietmeals/" + uId,
    );
    print(response);
    if (response.statusCode == 200) {
      loggedMeals.breakfast =
          List.from(jsonDecode(response.toString())['breakfast']);
      loggedMeals.lunch = List.from(jsonDecode(response.toString())['lunch']);
      loggedMeals.dinner = List.from(jsonDecode(response.toString())['dinner']);
      loggedMeals.snacks = List.from(jsonDecode(response.toString())['snacks']);
      loggedMeals.breakfast_daily_calories = List.from(
          jsonDecode(response.toString())['breakfast daily calories']);
      loggedMeals.lunch_daily_calories =
          List.from(jsonDecode(response.toString())['lunch daily calories']);
      loggedMeals.dinner_daily_calories =
          List.from(jsonDecode(response.toString())['dinner daily calories']);
      loggedMeals.snacks_daily_calories =
          List.from(jsonDecode(response.toString())['snacks daily calories']);
      print(loggedMeals.breakfast.length.toString() + " rrrrrrr");
    } else {
      throw Exception('failed to get logged meals');
    }
  }

  Future<num?> getPatientHistory(String uId) async {
    final response = await dio.get(
      GlobalUrl + "getHistory/" + uId,
    );

    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeHistory" +
          response.data.toString() +
          "                   ");

      patientHistories.add(history.fromJson(response.data));

      return response.statusCode;
    } else {
      throw Exception('failed to get history');
    }
  }

  Future<int?> getDoctorPatients() async {
    final response = await dio.get(
      GlobalUrl + "getdoctorpatients/" + uId,
      //  queryParameters: <String,dynamic>{'id': uId}
    );

    if (response.statusCode == 200) {
      print("ppppppppppppppppppppppppppp" +
          response.data['patients'].toString() +
          "                   ");

      doctorPatients = (response.data['patients'] as List)
          .map((data) => patient.fromJson(data))
          .toList();
      for (int i = 0; i < doctorPatients.length; i++) {
        await getPatientHistory(doctorPatients[i].uId);
      }

      return response.statusCode;
    } else {
      throw Exception('failed to get patients');
    }
  }

  void sendMessageTogroup({
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: currentpatient.uId,
        receiverId: currentpatient.Case,
        dateTime: dateTime,
        text: text);
    model.imageOfSender = currentpatient.image;

    //set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentpatient.Case)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> communityMessages = [];

  void getCommunityMessages() {
    for (int i = 0; i < patientsOfSameCase.length; i++) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentpatient.Case)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        communityMessages = [];
        event.docs.forEach((element) {
          communityMessages.add(MessageModel.fromJson(element.data()));
        });
        emit(SocialGetMessagesSuccessState());
      });
    }
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: uId, receiverId: receiverId, dateTime: dateTime, text: text);

    //set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  bool isfirstMessage = true;
  // Dio dio = new Dio();
  String chatbotMessage = "";
  void sendMessageToChatbot({
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: currentpatient.uId,
        receiverId: 'chatbot',
        dateTime: dateTime,
        text: text);

    //set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentpatient.uId)
        .collection('chats')
        .doc('chatbot')
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).then((value) async {
      debugPrint('sending message to chatbot' + currentpatient.uId);
      if (isfirstMessage) text += ' ' + currentpatient.uId;
      isfirstMessage = false;
      debugPrint('text is : ' + text);
      final response = await dio.post(chatbotUrl,
          //options: Options(headers: {"Content-Type": "application/json"}),
          data: json.encode(<String, String>{
            "message": text,
            "sender": currentpatient.username,
          }));
      debugPrint(response.toString() + response.statusCode.toString());
      //currentuser.fromJson(response.data);
      if (response.statusCode == 200) {
        debugPrint("##############333");
        debugPrint("in chatbot message" + response.data[0]["text"]);
        chatbotMessage = (response.data[0]["text"]);
      } else {
        emit(SocialSendMessageErrorState());
      }
    }).then((value) {
      MessageModel botModel = MessageModel(
          senderId: 'chatbot',
          receiverId: currentpatient.uId,
          dateTime: DateTime.now().toString(),
          text: chatbotMessage);

      FirebaseFirestore.instance
          .collection('users')
          .doc(currentpatient.uId)
          .collection('chats')
          .doc('chatbot')
          .collection('messages')
          .add(botModel.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      });
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }



  void getMessagesfromChatbot() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('chatbot')
        .collection('chats')
        .doc(currentpatient.uId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}
