import 'package:firstgp/modules/social_app/filter/snack_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/strings.dart';
import 'dart:ffi';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../globals/globalwidgets.dart';
import '../../../models/dish/dish_model.dart';
import '../filter/breakfast_filter_screen.dart';
import '../filter/lunch_filter_screen.dart';

class Generator extends StatefulWidget {
  String patientId;
  Generator({Key? key, required this.patientId}) : super(key: key);
  String text = 'Generate';
  bool isPressed = false;
  @override
  State<Generator> createState() => _Generator();
}

class _Generator extends State<Generator> {
  bool isButtonEnabled = false;

  bool _isEnabled() {
    if (calories == 0.0 ||
        carb == 0.0 ||
        protein == 0.0 ||
        fat == 0.0 ||
        carb < (calories / 1200) * 50.0 ||
        protein < (calories / 1200) * 30.0 ||
        fat < (calories / 1200) * 30.0 ||
        calories < 1200.0) {
      return false;
    }
    return true;
  }

  generateMeals() {
    setState(() {
      Breakfast = generateBreakfastMeals();
      Lunch = generateLunchMeals();

      Dinner = generateDinnerMeals();

      cur_calories =
          (bfCalories + lCalories + dCalories + s1Calories + s2Calories)
              .round();
      cur_carb = (bfCarb + lCarb + dCarb + s1Carb + s2Carb).round();
      cur_protein =
          (bfProtein + lProtein + dProtein + s1Protein + s2Protein).round();
      cur_fat = (bfProtein + lFat + dFat + s1Fat + s2Fat).round();

      generateSnacks();

      cur_calories =
          (bfCalories + lCalories + dCalories + s1Calories + s2Calories)
              .round();
      cur_carb = (bfCarb + lCarb + dCarb + s1Carb + s2Carb).round();
      cur_protein =
          (bfProtein + lProtein + dProtein + s1Protein + s2Protein).round();
      cur_fat = (bfProtein + lFat + dFat + s1Fat + s2Fat).round();
      bfCaloriesList.add(bfCalories);
      lCaloriesList.add(lCalories);
      dCaloriesList.add(dCalories);
      sCaloriesList.add(s1Calories + s2Calories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[500],
        title: const Text(
          "Meals Generator",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                value.isNotEmpty
                    ? caloriesBurnt = double.parse(value)
                    : caloriesBurnt = 0.0;
              },
              decoration: const InputDecoration(
                labelText: "Calories To Be Burnt",
                fillColor: Colors.green,
                //filled: true,
              ),
            ),
            Container(
              child: Row(children: [
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      value.isNotEmpty
                          ? calories = double.parse(value)
                          : calories = 0.0;
                      setState(() {
                        isButtonEnabled = _isEnabled();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Calories",
                      fillColor: Colors.green,
                      //filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      value.isNotEmpty
                          ? carb = double.parse(value)
                          : carb = 0.0;
                      setState(() {
                        isButtonEnabled = _isEnabled();
                      });
                    },
                    decoration: const InputDecoration(
                      //filled: true,
                      labelText: "Carb",
                      fillColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      value.isNotEmpty
                          ? protein = double.parse(value)
                          : protein = 0.0;
                      setState(() {
                        isButtonEnabled = _isEnabled();
                      });
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.green,
                      //filled: true,
                      labelText: "Protein",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      value.isNotEmpty ? fat = double.parse(value) : fat = 0.0;
                      setState(() {
                        isButtonEnabled = _isEnabled();
                      });
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.green,
                      //filled: true,
                      labelText: "Fat",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
              ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (widget.isPressed) Text('Day ' + counter.toString()),
            if (widget.isPressed)
              const SizedBox(
                height: 20.0,
              ),
            if (widget.isPressed)
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Column(
                    children: [
                      Text(
                        "Calories: $cur_calories",
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      Text("Carbohydrates: $cur_carb",
                          style: const TextStyle(fontSize: 15.0)),
                      Text("Protein: $cur_protein",
                          style: const TextStyle(fontSize: 15.0)),
                      Text("Fat: $cur_fat",
                          style: const TextStyle(fontSize: 15.0)),
                    ],
                  )),
            if (widget.isPressed)
              const SizedBox(
                height: 20.0,
              ),
            if (widget.isPressed)
              getmeal('Breakfast',bfCalories, Breakfast,
                  const Icon(Icons.breakfast_dining_outlined), context),
            if (widget.isPressed)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black54,
                    onPrimary: Colors.white,
                    primary: Colors.green[500]),
                child: const Text('Filter'),
                onPressed: () {
                  Filter = "breakfast";
                  createBadCombination(Breakfast);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BreakfastFilter(
                              patientId: widget.patientId,
                            )),
                  );
                },
              ),
            if (widget.isPressed)
              const SizedBox(
                height: 20.0,
              ),
            if (widget.isPressed)
              getmeal('Lunch',lCalories , Lunch,
                  const Icon(Icons.lunch_dining_outlined), context),
            if (widget.isPressed)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black54,
                    onPrimary: Colors.white,
                    primary: Colors.green[500]),
                child: const Text('Filter'),
                onPressed: () {
                  Filter = "lunch";
                  createBadCombination(Lunch);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LunchFilter(
                              patientId: widget.patientId,
                            )),
                  );
                },
              ),
            if (widget.isPressed)
              const SizedBox(
                height: 20.0,
              ),
            if (widget.isPressed)
              getmeal('Dinner',dCalories, Dinner,
                  const Icon(Icons.dinner_dining), context),
            if (widget.isPressed)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black54,
                    onPrimary: Colors.white,
                    primary: Colors.green[500]),
                child: const Text('Filter'),
                onPressed: () {
                  Filter = "dinner";
                  createBadCombination(Dinner);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BreakfastFilter(
                              patientId: widget.patientId,
                            )),
                  );
                },
              ),
            if (widget.isPressed)
              const SizedBox(
                height: 20.0,
              ),
            if (widget.isPressed)
              getmeal('First Snack', s1Calories , First_Snack,
                  const Icon(Icons.food_bank_outlined), context),
            if (widget.isPressed)
              const SizedBox(
                height: 20.0,
              ),
            if (widget.isPressed)
              getmeal('Second Snack', s2Calories , Second_Snack,
                  const Icon(Icons.food_bank_outlined), context),
            if (widget.isPressed)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black54,
                    onPrimary: Colors.white,
                    primary: Colors.green[500]),
                child: const Text('Filter'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SnacksFilter(
                              patientId: widget.patientId,
                            )),
                  );
                },
              ),
            if (widget.isPressed)
              const SizedBox(
                height: 20.0,
              ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.white,
                    onPrimary: Colors.white,
                    primary: Colors.green[500]),
                child: Text(widget.text),
                onPressed: (isButtonEnabled)
                    ? () async {
                        if (!widget.isPressed) {
                          widget.isPressed = true;
                          setState(() {});
                        }
                        await getMeals();
                        await generateMeals();
                        counter++;
                        if (counter == 7) {
                          widget.text = 'Save';
                          setState(() {});
                        }
                        if (counter == 8) {
                          await createDiet(widget.patientId);
                          showToast(true, 'Meals saved successfully');
                          setAllMealsToZero();
                          Navigator.pop(context);
                        }
                      }
                    : null),
          ]),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

Widget getmeal(String title,num calories, String content, Icon icon, context) => Container(
      color: Colors.white70,
      child: Column(children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(title +'   '+calories.round().toString()+' calories'),
            const SizedBox(width: 30),
          ],
        ),
        const SizedBox(
          height: 15,
          width: double.infinity,
          child: Divider(
            color: Colors.black45,
          ),
        ),
        content != null
            ? Text(content, style: const TextStyle(fontSize: 13))
            : const Text("no meal today"),
        const SizedBox(
          height: 10,
        )
      ]),
    );
