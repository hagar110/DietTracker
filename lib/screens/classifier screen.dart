import 'package:firstgp/globals/globalFunctions.dart';
import 'package:firstgp/screens/doctorDetails.dart';
import 'package:flutter/material.dart';

import '../apiServices/classifier.dart';
import '../models/doctor.dart';
//import 'package:tflite_flutter_plugin_example/classifier.dart';

class classifier extends StatefulWidget {
  doctor doc;
  classifier({required this.doc});
  @override
  _classifierState createState() => _classifierState();
}

class _classifierState extends State<classifier> {
  late TextEditingController _controller;
  late Classifier _classifier;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _classifier = Classifier();
    _children = [];
    _children.add(Container());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green[400],
                title: const Text('Feedback'),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              doctorDetails(Doctor: widget.doc)),
                      (route) => false,
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back, // add custom icons also
                  ),
                )),
            body: Container(
                padding: const EdgeInsets.all(4),
                child: Column(children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                    itemCount: _children.length,
                    itemBuilder: (_, index) {
                      return _children[index];
                    },
                  )),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent)),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Write your feedback here'),
                            controller: _controller,
                          ),
                        ),
                        TextButton(
                            child: const Text('Submit'),
                            onPressed: () async {
                              final text = _controller.text;
                              var prediction = _classifier.classify(text);
                              if (prediction[1] > prediction[0]) {
                                await api.increaseScore(widget.doc.uId);
                              } else {
                                await api.decreaseScore(widget.doc.uId);
                              }
                              setState(() {
                                _children.add(Dismissible(
                                  key: GlobalKey(),
                                  onDismissed: (direction) {},
                                  child: Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      color: prediction[1] > prediction[0]
                                          ? Colors.lightGreen
                                          : Colors.redAccent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Text('thanks for your feedback'),
                                          /*   Text(
                                            "Input: $text",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text("Output:"),
                                          if (prediction[1] > prediction[0])
                                            Text(
                                                "   Positive: ${prediction[1]}")
                                          else
                                            Text(
                                                "   Negative: ${prediction[0]}"),
                                       */
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                                _controller.clear();
                              });
                            })
                      ]))
                ]))));
  }
}
