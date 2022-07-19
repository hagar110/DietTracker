// ignore_for_file: prefer_const_constructors

import 'package:firstgp/apiServices/api.dart';
import 'package:firstgp/globals/globalFunctions.dart';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/models/patient.dart';
import 'package:firstgp/modules/social_app/generator/generator_screen.dart';
import 'package:firstgp/modules/social_app/patients/patient_behaviour_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/dish/meal_model.dart';
import '../models/history.dart';

class CustomContainer_Patients extends StatelessWidget {
  patient Patient;
  history History;

  CustomContainer_Patients({required this.Patient, required this.History});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 360,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        child: Row(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
                  Patient.username,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 102, 102, 110)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Current weight: ' + History.weight.toString()+" Kg",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  (History.preweight==0)?' Previous weight: ' + History.weight.toString()+" Kg":
                  ' Previous weight: ' + History.preweight.toString()+" Kg",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Total weight loss: ' + History.totalweightlost.toString()+" Kg",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Height: ' + History.height!.round().toString()+" Cm",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  ' BMI: ' + History.BMI!.round().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  ' PBF: ' + History.PBF.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  ' PBW : ' + History.PBW.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),
                Container(
                  width: 200,
                  child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(
                        left: 3.0,
                      ),
                      leading: Icon(Icons.read_more, size: 15),
                      title: Transform.translate(
                          offset: Offset(-35, 0),
                          child: Text(
                            "set patient meals",
                            style: TextStyle(
                                fontSize: 15, color: Colors.green[400]),
                          )),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Generator(patientId: Patient.uId)),
                        );
                        //api.registerAdoctor(Doctor.uId);
                      }


                      ),
                ),
                Container(
                  width: 200,
                  child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(
                        left: 3.0,
                      ),
                      leading: Icon(Icons.read_more, size: 15),
                      title: Transform.translate(
                          offset: Offset(-35, 0),
                          child: Text(
                            "view patient behaviour",
                            style: TextStyle(
                                fontSize: 15, color: Colors.green[400]),
                          )),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PatientBehaviour(uId: Patient.uId,name: Patient.username,)),
                        );
                        //api.registerAdoctor(Doctor.uId);
                      }


                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(backgroundColor: Colors.green[100],radius: 50.0, backgroundImage: NetworkImage(Patient.image)),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
