import 'package:flutter/material.dart';

import '../globals/globalVariables.dart';
import '../globals/globalwidgets.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    authData['isdoctor'] = 'true';
    authData['gender'] = 'male';
    authData['height'] = '60.0';
    authData['weight'] = '60.0';
    authData['age'] = '20';
    authData['case'] = 'none';
  }

  confirmPasswordValidation(String value) {
    if (value.isEmpty)
      return 'empty password';
    else if (value != passwordController.text) return 'does not match password';

    return null;
  }

//detection price
  final detectionController = TextEditingController();
  final usernameController = TextEditingController();
  final clinicController = TextEditingController();
  final visitaController = TextEditingController();
  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final emailController = TextEditingController();
  bool isdoctor = true;

  bool isMale = true;
  double height = 120.0;
  double weight = 60.0;
  int age = 20;
  String dropdownValue = 'none';
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      defaultTextForm(controller: usernameController, text: 'Username'),
      SizedBox(
        height: 5,
      ),
      defaultTextForm(controller: emailController, text: 'Email'),
      SizedBox(
        height: 5,
      ),
      passwordDefaultTextFiled(provider.showPassword, 'Password',
          passwordController, 0, passwordController),
      passwordDefaultTextFiled(provider.showConfirmPassword, 'Confirm password',
          confirmPasswordController, 1, passwordController),
      if (isdoctor)
        defaultTextForm(controller: clinicController, text: 'Clinic number'),
      if (isdoctor)
        SizedBox(
          height: 5,
        ),
      if (isdoctor)
        defaultTextForm(
            controller: visitaController, text: 'Veseeta profile URL'),
      if (isdoctor)
        SizedBox(
          height: 5,
        ),
      if (isdoctor)
        defaultTextForm(
            controller: detectionController, text: 'Detection price'),
      if (isdoctor)
        SizedBox(
          height: 5,
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Gender : ",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          GestureDetector(
            child: Container(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.male,
                    size: 30.0,
                  ),
                  Text(
                    'Male',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: isMale ? Colors.lightGreen : Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.circular(20.0)),
            ),
            onTap: () {
              setState(() {
                isMale = true;
                authData['gender'] = 'male';
              });
            },
          ),
          GestureDetector(
            child: Container(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.female,
                    size: 30.0,
                  ),
                  Text(
                    'Female',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: !isMale ? Colors.lightGreen : Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.circular(20.0)),
            ),
            onTap: () {
              setState(() {
                isMale = false;
                authData['gender'] = 'female';
              });
            },
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Role : ",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          GestureDetector(
            child: Container(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.health_and_safety_sharp,
                    size: 30.0,
                  ),
                  Text(
                    'doctor',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: isdoctor ? Colors.lightGreen : Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.circular(20.0)),
            ),
            onTap: () {
              setState(() {
                isdoctor = true;
                authData['isdoctor'] = 'true';
             });
            },
          ),
          GestureDetector(
            child: Container(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.sick,
                    size: 30.0,
                  ),
                  Text(
                    'Patient',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: !isdoctor ? Colors.lightGreen : Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.circular(20.0)),
            ),
            onTap: () {
              setState(() {
                isdoctor = false;
                authData['isdoctor'] = 'false';
              });
            },
          ),
        ],
      ),
      if (!isdoctor)
        if (!isdoctor) SizedBox(height: 10),
      if (!isdoctor)
        Container(
          height: 85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'HEIGHT',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${height.round()}',
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'CM',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                  value: height,
                  max: 200.0,
                  min: 30.0,
                  onChanged: (value) {
                    setState(() {
                      height = value;
                      authData['height'] = height.toString();
                    });
                  })
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300]!.withOpacity(0.3),
              borderRadius: BorderRadiusDirectional.circular(20.0)),
        ),
      if (!isdoctor)
        SizedBox(
          height: 15,
        ),
      if (!isdoctor)
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Weight',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$weight',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      FloatingActionButton(
                        heroTag: 'weight-',
                        onPressed: () {
                          setState(() {
                            weight--;
                            authData['weight'] = weight.toString();
                          });
                        },
                        mini: true,
                        child: const Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        heroTag: 'weight+',
                        onPressed: () {
                          setState(() {
                            weight++;
                            authData['weight'] = weight.toString();
                          });
                        },
                        mini: true,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Age',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$age',
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      FloatingActionButton(
                        heroTag: 'age-',
                        onPressed: () {
                          setState(() {
                            age--;
                            authData['age'] = age.toString();
                          });
                        },
                        mini: true,
                        child: const Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        heroTag: 'age+',
                        onPressed: () {
                          setState(() {
                            age++;
                            authData['age'] = age.toString();
                          });
                        },
                        mini: true,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300]!.withOpacity(0.3),
              borderRadius: BorderRadiusDirectional.circular(20.0)),
        ),
      if (!isdoctor)
        SizedBox(
          height: 10,
        ),
      if (!isdoctor)
        Container(
          color: Colors.grey.withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'case: ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              DropdownButton<String>(
                  value: dropdownValue,
                  focusColor: Colors.cyan,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                      authData['case'] = dropdownValue;
                    });
                  },
                  items: <String>[
                    'none',
                    'diabetes',
                    'high blood pressure',
                    'heart problems',
                    'kidney problems',
                    'severe diseases'
                  ].map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: new Text(val),
                    );
                  }).toList()),
            ],
          ),
        ),
    ]);
  }
}
