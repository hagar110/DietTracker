import 'package:flutter/material.dart';

import '../globals/globalVariables.dart';
import '../layout/social_app/cubit/cubit.dart';
import '../models/doctor.dart';
import '../widgets/customContainerWidget.dart';

class doctorsScreen extends StatefulWidget {
  @override
  _doctorsScreenState createState() => _doctorsScreenState();
}

class _doctorsScreenState extends State<doctorsScreen> {
  @override
  void initState() {
    tempDoctors = doctors;
  }

  bool viewTextField = false;
  TextEditingController priceController = new TextEditingController();

  String dropdownValue = 'all';
  double inputPrice = 200;
  List<doctor> viewDoctors = [];
  List<doctor> tempDoctors = [];
  bool init = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Row(
            children: [
              Text('filter by: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black54)),
              DropdownButton<String>(
                  value: dropdownValue,
                  focusColor: Colors.cyan,
                  onChanged: (String? value) async {
                    dropdownValue = value!;
                    viewDoctors.clear();
                    if (value == 'price') {
                      setState(() {
                        viewTextField = true;
                      });
                      print("priceeeeeeeeeeeeeeeee");
                      //List<doctor> viewDoctors = [];
                    } else if (value == 'all') {
                      viewDoctors = doctors;
                      setState(() {
                        viewTextField = false;
                        tempDoctors = viewDoctors;
                      });
                    } else if (value == 'only males') {
                      tempDoctors = [];
                      for (int i = 0; i < doctors.length; i++) {
                        if (doctors[i].Gender == "male") {
                          tempDoctors.add(doctors[i]);
                        }
                      }
                      setState(() {
                        viewTextField = false;
                      });
                    } else {
                      tempDoctors = [];
                      for (int i = 0; i < doctors.length; i++) {
                        if (doctors[i].Gender == "female") {
                          tempDoctors.add(doctors[i]);
                        }
                      }
                      setState(() {
                        viewTextField = false;
                      });
                    }
                  },
                  items: <String>['all', 'price', 'only males', 'only females']
                      .map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: new Text(val),
                    );
                  }).toList()),
            ],
          ),
        ),
        if (viewTextField)
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            onSubmitted: (val) {
              viewDoctors.clear();
              inputPrice = double.parse(val);
              double mindiff = 100000000000000;
              int index = -1;
              for (int i = 0; i < doctors.length; i++) {
                print(doctors[i].price - inputPrice);
                if ((doctors[i].price - inputPrice).abs() <= mindiff) {
                  index = i;
                  mindiff = (doctors[i].price - inputPrice).abs();
                }
              }
              if (!viewDoctors.contains(doctors[index])) {
                viewDoctors.add(doctors[index]);
              }
              setState(() {
                print("vieww doctors: " + viewDoctors.toString());
                tempDoctors = viewDoctors;
              });
            },
          ),
        FutureBuilder<void>(
            future: SocialCubit.get(context).getdoctors(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              List<Widget> children;
              if (snapshot.connectionState == ConnectionState.done) {
                tempDoctors = (init) ? doctors : tempDoctors;
                init = false;
                children = <Widget>[
                  SizedBox(
                    // height: double.infinity,
                    width: double.infinity,
                    child: ListView.builder(
                        //scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tempDoctors.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomContainer_HomePage(
                            Doctor: tempDoctors[index],
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
