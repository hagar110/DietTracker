import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/social_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../globals/globalFunctions.dart';

class takeMealsAmountWidget extends StatelessWidget {
  String meal;
  //List items;
  takeMealsAmountWidget({required this.meal});

  @override
  Widget build(BuildContext context) {
    // var t=TextEditingController();
    List<TextEditingController> _mealAmountController = [];
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SocialLayout()),
                    (route) => false);
              }),
        ]),
        body: SingleChildScrollView(
          child: Container(
              //height: double.infinity,
              child: Column(
            children: [
              ListView.builder(
                  //scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Selected.length,
                  itemBuilder: (BuildContext context, int index) {
                    _mealAmountController.add(TextEditingController());
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  child: TextField(
                                    cursorWidth: 20,
                                    decoration: InputDecoration(
                                        labelText: "add amount",
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black12),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.green[300]!
                                                  .withOpacity(1),
                                              width: 3),
                                        )),
                                    controller: _mealAmountController[index],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (meal == "Breakfast")
                                      ? breakfastMealsStr[Selected[index]]
                                      : (meal == "Lunch")
                                          ? lunchMealsStr[Selected[index]]
                                          : (meal == "Dinner")
                                              ? breakfastMealsStr[
                                                  Selected[index]]
                                              : snacksMealsStr[Selected[index]],
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                          child: Divider(
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    );
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 13, 164, 28),
                  ),
                  child: const Text('Done'),
                  onPressed: () async {
                    await logmeal(_mealAmountController, meal);
                    //await getAllMeals();
                  }),
            ],
          )),
        ));
  }
}
