import 'package:firstgp/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';
import '../generator/generator_screen.dart';

class SnacksFilter extends StatefulWidget {
  String patientId;
  SnacksFilter({Key? key, required this.patientId}) : super(key: key);

  @override
  State<SnacksFilter> createState() => _SnacksFilter();
}

class _SnacksFilter extends State<SnacksFilter> {
  bool isButtonEnabled = false;

  bool _isEnabled() {
    if (amountSnack1 == 0.0 || amountSnack2 == 0.0) {
      return false;
    }
    return true;
  }

  void setAll() async {
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
    First_Snack = await saveSnack1();
    Second_Snack = await saveSnack2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green[500]
          ,title: Text('Filter Lunch')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              value.isNotEmpty
                  ? amountSnack1 = double.parse(value)
                  : amountSnack1 = 0.0;
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
            value: filterSnack1,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.green[500],
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterSnack1 = newValue!;
              });
            },
            items: snacks.map<DropdownMenuItem<Dish>>((Dish value) {
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
                  ? amountSnack2 = double.parse(value)
                  : amountSnack2 = 0.0;
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
            value: filterSnack2,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.green[500],
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterSnack2 = newValue!;
              });
            },
            items: snacks.map<DropdownMenuItem<Dish>>((Dish value) {
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
    );
  }
}
