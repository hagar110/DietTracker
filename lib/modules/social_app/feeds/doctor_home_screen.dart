import 'package:firstgp/globals/globalVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("233333" + currentdoctor.newsfeed.toString());
    return (currentdoctor.newsfeed.isEmpty)
        ? Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 40.0,
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..strokeWidth = 2.5
                          ..color = Colors.green[500]!,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Dr ' + currentdoctor.username,
                      style: TextStyle(
                        fontSize: 50.0,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.green[500]!,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'to Dietido App',
                      style: TextStyle(
                        fontSize: 50.0,
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..strokeWidth = 3
                          ..color = Colors.green[500]!,
                      ),
                    ),
                  ],
                )))
        : ListView.builder(
            //scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: currentdoctor.newsfeed.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                      color: Colors.white60,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.notification_important,
                            color: Color.fromARGB(255, 68, 139, 9),
                          ),
                          Container(
                              height: 70,
                              child: Center(
                                child: Text(
                                  currentdoctor.newsfeed[index],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 68, 139, 9)),
                                ),
                              )),
                        ],
                      )),
                  Divider(
                    color: Colors.green[500],
                  )
                ],
              );
            });
  }
}
