import 'package:firstgp/modules/social_app/generator/generator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';

class BreakfastFilter extends StatefulWidget {
  String patientId;
  BreakfastFilter({Key? key, required this.patientId}) : super(key: key);

  @override
  State<BreakfastFilter> createState() => _BreakfastFilter();
}

class _BreakfastFilter extends State<BreakfastFilter> {
  bool isButtonEnabled = false;

  bool _isEnabled() {
    if (amountFilterBreakfastProtein == 0.0 ||
        amountFilterBreakfastCarb == 0.0 ||
        amountFilterBreakfastVegeies == 0.0 ||
        amountFilterBreakfastDairyAndLegumes == 0.0) {
      return false;
    }
    return true;
  }

  void setAll() async {
    Filter == "breakfast"
        ? Breakfast = await saveChange()
        : Dinner = await saveChange();
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
      ,title: Text(Filter == "breakfast"?'Filter Breakfast':'Filter Dinner')),
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
                    ? amountFilterBreakfastProtein = double.parse(value)
                    : amountFilterBreakfastProtein = 0.0;
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
              value: filterBreakfastProtein,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.green[500],
              ),
              onChanged: (Dish? newValue) {
                setState(() {
                  filterBreakfastProtein = newValue!;
                });
              },
              items: breakfastProtein.map<DropdownMenuItem<Dish>>((Dish value) {
                return DropdownMenuItem<Dish>(
                  value: value,
                  child: Text(value.Name),
                );
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                value.isNotEmpty
                    ? amountFilterBreakfastCarb = double.parse(value)
                    : amountFilterBreakfastCarb = 0.0;
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
              value: filterBreakfastCarb,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.green[500],
              ),
              onChanged: (Dish? newValue) {
                setState(() {
                  filterBreakfastCarb = newValue!;
                });
              },
              items: breakfastCarb.map<DropdownMenuItem<Dish>>((Dish value) {
                return DropdownMenuItem<Dish>(
                  value: value,
                  child: Text(value.Name),
                );
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                value.isNotEmpty
                    ? amountFilterBreakfastVegeies = double.parse(value)
                    : amountFilterBreakfastVegeies = 0.0;
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
              value: filterBreakfastVegeies,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.green[500],
              ),
              onChanged: (Dish? newValue) {
                setState(() {
                  filterBreakfastVegeies = newValue!;
                });
              },
              items: breakfastVegeies.map<DropdownMenuItem<Dish>>((Dish value) {
                return DropdownMenuItem<Dish>(
                  value: value,
                  child: Text(value.Name),
                );
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                value.isNotEmpty
                    ? amountFilterBreakfastDairyAndLegumes = double.parse(value)
                    : amountFilterBreakfastDairyAndLegumes = 0.0;
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
              value: filterBreakfastDairyAndLegumes,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.green[500],
              ),
              onChanged: (Dish? newValue) {
                setState(() {
                  filterBreakfastDairyAndLegumes = newValue!;
                });
              },
              items: breakfastDairyAndLegumes
                  .map<DropdownMenuItem<Dish>>((Dish value) {
                return DropdownMenuItem<Dish>(
                  value: value,
                  child: Text(value.Name),
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
