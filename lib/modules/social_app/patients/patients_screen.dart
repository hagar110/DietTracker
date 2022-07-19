import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/models/patient.dart';
import 'package:flutter/material.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../widgets/customContainerWidget_2.dart';



class PatientsScreen extends StatefulWidget {
  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<void>(
            future: SocialCubit.get(context).getDoctorPatients(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              List<Widget> children;
              if (snapshot.connectionState == ConnectionState.done) {
                children = <Widget>[
                  SizedBox(
                    height: 900,
                    width: double.infinity,
                    child: ListView.builder(
                        //scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: doctorPatients.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomContainer_Patients(
                            Patient: doctorPatients[index],
                            History: patientHistories[index],
                          );
                        }),
                  ),
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
                return CircularProgressIndicator();
              } else {
                children = const <Widget>[
                  Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ];
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            }),
      ],
    );
  }
}
