import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/cubit/cubit.dart';
import 'package:firstgp/layout/social_app/social_layout.dart';
import 'package:firstgp/screens/classifier%20screen.dart';
import 'package:firstgp/screens/doctorsScreen.dart';
import 'package:flutter/material.dart';

import '../models/doctor.dart';

class doctorDetails extends StatefulWidget {
  doctor Doctor;

  doctorDetails({Key? key, required this.Doctor}) : super(key: key);

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

class _doctorDetailsState extends State<doctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 57,
                          backgroundColor: Colors.green[200],
                          child: CircleAvatar(
                              radius: 55.0,
                              backgroundColor: Colors.green[100],
                              backgroundImage:
                                  NetworkImage(widget.Doctor.image)),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20, bottom: 50.0),
                          child: Text(
                            widget.Doctor.username,
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Row(
                        children: [
                          if (currentPatientDoctor == null)
                            FlatButton(
                                onPressed: () async => {
                                      await api.registerAdoctor(
                                          widget.Doctor.uId, widget.Doctor),
                                      setState(() {})
                                    },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_alert_sharp,
                                      size: 20,
                                      color: Colors.green[400],
                                    ),
                                    Text(
                                      " subscribe ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[400]),
                                    )
                                  ],
                                )),
                          if (currentPatientDoctor != null &&
                              currentPatientDoctor!.uId == widget.Doctor.uId)
                            FlatButton(
                                onPressed: () async => {
                                      await api.unsubscribeAdoctor(
                                          widget.Doctor.uId),
                                      setState(() {})
                                    },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.unsubscribe,
                                      size: 20,
                                      color: Colors.green[400],
                                    ),
                                    Text(
                                      " unsubscribe ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[400]),
                                    )
                                  ],
                                )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.green[400],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text("detection price: ",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(widget.Doctor.price.toString(),
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Gender: ",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(widget.Doctor.Gender,
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text("clinic phone :",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(widget.Doctor.cliniquePhone,
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Material(
                color: Colors.white,
                child: Column(
                  children: [
                    if (currentPatientDoctor != null &&
                        currentPatientDoctor!.uId == widget.Doctor.uId)
                      FlatButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => classifier(
                                    doc: widget.Doctor,
                                  ),
                                ),
                                (route) => false,
                              ),
                          child: Container(
                            //color: Colors.green[400]!.withOpacity(0.5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.green[400]!.withOpacity(0.1),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black45,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Text(
                                'click here to give your feedback about doctor ' +
                                    widget.Doctor.username,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 15, color: Colors.black45)),
                          )),
                    IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SocialLayout(),
                            ),
                            (route) => false,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.green[400],
                          size: 50,
                        )),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
