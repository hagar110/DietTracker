import 'package:firstgp/layout/social_app/cubit/cubit.dart';
import 'package:firstgp/layout/social_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;
import 'dart:async';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/icon_broken.dart';

class ScanInbodyScreen extends StatefulWidget {
  const ScanInbodyScreen({Key? key}) : super(key: key);

  @override
  State<ScanInbodyScreen> createState() => _ScanInbodyScreenState();
}

class _ScanInbodyScreenState extends State<ScanInbodyScreen> {
  final editableHeightController = TextEditingController();

  final editableBfmController = TextEditingController();

  final editableTbwController = TextEditingController();

  final editableWeightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  String height = "", weight = "", TotalBodyWater = "", BodyFatMass = "";

  String parsedtext = '';

  List<String> lines = [];

  parseWeightAndHeight() {
    for (int i = 0; i < lines[0].length; i++) {
      if (lines[0][i] == 'c') break;
      height += lines[0][i];
    }
    for (int i = 0; i < lines[8].length; i++) {
      if (lines[8][i] == ' ') break;
      weight += lines[8][i];
    }
    for (int i = 0; i < lines[4].length; i++) {
      if (lines[4][i] == ' ') break;
      TotalBodyWater += lines[4][i];
    }
    for (int i = 0; i < lines[7].length; i++) {
      if (lines[7][i] == ' ') break;
      BodyFatMass += lines[7][i];
    }
    print('height is ' + height + '   weight is : ' + weight);
    editableHeightController.text = height;
    editableWeightController.text = weight;
    editableBfmController.text = BodyFatMass;
    editableTbwController.text = TotalBodyWater;
  }

  Future parsethetext() async {
    // pick a image
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(source: ImageSource.gallery);
    final imagefile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 670, maxHeight: 970);
    // prepare the image
    var bytes = Io.File(imageFile!.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    // send to api
    String url = 'https://api.ocr.space/parse/image';
    var payload = {"base64Image": "data:image/jpg;base64,${img64.toString()}"};
    var header = {"apikey": apikey};

    var post = await http.post(Uri.parse(url), body: payload, headers: header);

    // get result from api
    var result = jsonDecode(post.body);
    setState(() {
      print(result);
      parsedtext = result['ParsedResults'][0]['ParsedText'];
      LineSplitter ls = new LineSplitter();
      List<String> temp = ls.convert(parsedtext);
      for (var i = 0; i < temp.length; i++) {
        if (double.tryParse(temp[i][0]) != null) {
          print('lines $i: ${temp[i]}');
          lines.add(temp[i]);
        }
        print('temp $i: ${temp[i]}');
      }
      parseWeightAndHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUserUpdateSuccessState) {
          showToast(
            text: 'Updated',
            state: ToastStates.SUCCESS,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_2,
                ),
              ),
              context: context,
              title: 'Scan InBody',
              actions: [
                defaultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUserInBody(
                        height: double.parse(editableHeightController.text),
                        weight: double.parse(editableWeightController.text),
                        PBF: num.parse(editableBfmController.text),
                        PBW: num.parse(editableTbwController.text));
                    setState(() {});
                  },
                  text: 'Update',
                )
              ]),
          body: Center(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  alignment: Alignment.center,
                  child: Text(
                    "OCR APP",
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                      onPressed: () => parsethetext(),
                      child: Text(
                        'Upload a image',
                      )),
                ),
                SizedBox(height: 70.0),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "ParsedHeightAndWeight is:",
                      ),
                      SizedBox(height: 10.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(children: [
                                Flexible(flex: 1, child: Text('height: ')),
                                Flexible(
                                  flex: 2,
                                  child: defaultTextFormField(
                                    context: context,
                                    controller: editableHeightController,
                                    text: 'height',
                                  ),
                                ),
                              ]),
                              SizedBox(height: 30.0),
                              Row(children: [
                                Flexible(flex: 1, child: Text('weight: ')),
                                Flexible(
                                  flex: 2,
                                  child: defaultTextFormField(
                                    context: context,
                                    controller: editableWeightController,
                                    text: 'weight',
                                  ),
                                ),
                              ]),
                              SizedBox(height: 30.0),
                              Row(children: [
                                Flexible(
                                    flex: 1, child: Text('Total body Water: ')),
                                Flexible(
                                  flex: 2,
                                  child: defaultTextFormField(
                                    context: context,
                                    controller: editableTbwController,
                                    text: 'Total body Water',
                                  ),
                                ),
                              ]),
                              SizedBox(height: 30.0),
                              Row(children: [
                                Flexible(
                                    flex: 1, child: Text('Body fat Mass: ')),
                                Flexible(
                                  flex: 2,
                                  child: defaultTextFormField(
                                    context: context,
                                    controller: editableBfmController,
                                    text: 'Body fat Mass',
                                  ),
                                ),
                              ]),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
