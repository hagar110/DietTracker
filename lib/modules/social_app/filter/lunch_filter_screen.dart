import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';
import '../generator/generator_screen.dart';

class LunchFilter extends StatefulWidget {
  String patientId;
  LunchFilter({Key? key, required this.patientId}) : super(key: key);

  @override
  State<LunchFilter> createState() => _LunchFilter();
}

class _LunchFilter extends State<LunchFilter> {
  bool isButtonEnabled = false;

  bool _isEnabled() {
    if (amountFilterLunchProtein == 0.0 ||
        amountFilterLunchCarb == 0.0 ||
        amountFilterLunchVegeiesAndLegumes == 0.0) {
      return false;
    }
    return true;
  }

  setAll() async {
    Lunch = await saveChange();
    cur_calories =
        (bfCalories + lCalories + dCalories + s1Calories + s2Calories).round();
    cur_carb = (bfCarb + lCarb + dCarb + s1Carb + s2Carb).round();
    cur_protein =
        (bfProtein + lProtein + dProtein + s1Protein + s2Protein).round();
    cur_fat = (bfProtein + lFat + dFat + s1Fat + s2Fat).round();
    bfCaloriesList[bfCaloriesList.length - 1] = bfCalories;
    lCaloriesList[lCaloriesList.length - 1] = (lCalories);
    dCaloriesList[dCaloriesList.length - 1] = (dCalories);
    sCaloriesList[sCaloriesList.length - 1] = (s1Calories + s2Calories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green[500]
          ,title: Text('Filter Lunch')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                value.isNotEmpty
                    ? amountFilterLunchProtein = double.parse(value)
                    : amountFilterLunchProtein = 0.0;
                setState(() {
                  isButtonEnabled = _isEnabled();
                });
              },
              decoration: const InputDecoration(
                labelText: "Amount",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            DropdownButton<Dish>(
              //isDense: true,
              hint: Text('Choose'),
              value: filterLunchProtein,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.green[500],
              ),
              onChanged: (Dish? newValue) {
                setState(() {
                  filterLunchProtein = newValue!;
                });
              },
              items: lunchProtein.map<DropdownMenuItem<Dish>>((Dish value) {
                return DropdownMenuItem<Dish>(
                  value: value,
                  child: Text(value.Name,
                      style: TextStyle(
                        fontSize: 13,
                      )),
                );
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                value.isNotEmpty
                    ? amountFilterLunchCarb = double.parse(value)
                    : amountFilterLunchCarb = 0.0;
                setState(() {
                  isButtonEnabled = _isEnabled();
                });
              },
              decoration: const InputDecoration(
                labelText: "Amount",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            DropdownButton<Dish>(
              //isDense: true,
              hint: Text('Choose'),
              value: filterLunchCarb,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.green[500],
              ),
              onChanged: (Dish? newValue) {
                setState(() {
                  filterLunchCarb = newValue!;
                });
              },
              items: lunchCarb.map<DropdownMenuItem<Dish>>((Dish value) {
                return DropdownMenuItem<Dish>(
                  value: value,
                  child: Text(value.Name,
                      style: TextStyle(
                        fontSize: 13,
                      )),
                );
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                value.isNotEmpty
                    ? amountFilterLunchVegeiesAndLegumes = double.parse(value)
                    : amountFilterLunchVegeiesAndLegumes = 0.0;
                setState(() {
                  isButtonEnabled = _isEnabled();
                });
              },
              decoration: const InputDecoration(
                labelText: "Amount",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            DropdownButton<Dish>(
              //isDense: true,
              hint: Text('Choose'),
              value: filterLunchVegeiesAndLegumes,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.green[500],
              ),
              onChanged: (Dish? newValue) {
                setState(() {
                  filterLunchVegeiesAndLegumes = newValue!;
                });
              },
              items: lunchVegeiesAndLegumes
                  .map<DropdownMenuItem<Dish>>((Dish value) {
                return DropdownMenuItem<Dish>(
                  value: value,
                  child: Text(value.Name,
                      style: TextStyle(
                        fontSize: 13,
                      )),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 40.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green[500],
              ),
              child: const Text('Save'),
              onPressed: isButtonEnabled
                  ? () async {
                      setAll();
                      Navigator.pop(context);
                    }
                  : null,
            ),
          ]),
        ),
      ),
    );
  }
}
