// ignore_for_file: prefer_const_constructors

import 'package:firstgp/apiServices/api.dart';
import 'package:firstgp/globals/globalFunctions.dart';
import 'package:firstgp/models/doctor.dart';
import 'package:firstgp/screens/doctorDetails.dart';
import 'package:firstgp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer_HomePage extends StatelessWidget {
  doctor Doctor;

  CustomContainer_HomePage({required this.Doctor});
  @override
  Widget build(BuildContext context) {
    //   debugPrint('in container ' + doctorId);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 360,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Dr ' + Doctor.username,
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 102, 102, 110)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      Doctor.ratingScore.toString(),
                      style: TextStyle(
                          fontSize: 15, color: Colors.green
                      ),
                    ),
          Icon(
             Icons.star,
            color: Colors.green,
            size: 10.0,
          ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'detection price : ' + Doctor.price.toString(),
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
                            "see doctor details",
                            style: TextStyle(
                                fontSize: 15, color: Colors.green[400]),
                          )),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                doctorDetails(Doctor: Doctor),
                          ),
                          (route) => false,
                        );
                        //api.registerAdoctor(Doctor.uId);
                      }


                      ),
                )
              ],
            ),
            CircleAvatar(backgroundColor: Colors.green[100],radius: 25.0, backgroundImage: NetworkImage(Doctor.image)),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
