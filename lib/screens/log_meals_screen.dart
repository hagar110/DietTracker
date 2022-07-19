import 'package:firstgp/layout/social_app/social_layout.dart';
import 'package:firstgp/modules/social_app/feeds/feeds_screen.dart';
import 'package:firstgp/screens/takeMealsAmount.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';

class logMeals extends StatefulWidget {
  String meal;
  logMeals(this.meal);

  @override
  State<logMeals> createState() => _logMeals();
}

class _logMeals extends State<logMeals> {
  @override
  Widget build(BuildContext context) {
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
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          /* MultiSelectDialogField(
                items: 
                (widget.meal=="breakfast") ?
                 bfMeals:(widget.meal=="lunch")?lMeals:(widget.meal=="dinner")?dMeals:sMeals,
                
                title: Text(widget.meal),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                (widget.meal=="breakfast") ?
                 Icons.breakfast_dining:(widget.meal=="lunch")?Icons.lunch_dining:Icons.food_bank,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  widget.meal,
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  //_selectedAnimals = results;
                },
              ),*/
          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       primary: Color.fromARGB(255, 13, 164, 28),
          //     ),
          //     child: const Text('get Meals'),
          //     onPressed: () async {
          //       await getAllMeals();
          //     }),
          Container(
            child: GFMultiSelect(
              items: //allMealsStr,
                  (widget.meal == "Breakfast")
                      ? breakfastMealsStr
                      : (widget.meal == "Lunch")
                          ? lunchMealsStr
                          : (widget.meal == "Dinner")
                              ? breakfastMealsStr
                              : snacksMealsStr,
              onSelect: (value) {
                debugPrint(value.toString());
                Selected = value;
              },
              dropdownTitleTileText: 'Select',
              dropdownTitleTileColor: Colors.grey[200],
              dropdownTitleTileMargin:
                  EdgeInsets.only(top: 22, left: 18, right: 18, bottom: 5),
              dropdownTitleTilePadding: EdgeInsets.all(10),
              dropdownUnderlineBorder:
                  const BorderSide(color: Colors.transparent, width: 2),
              dropdownTitleTileBorder:
                  Border.all(color: Color.fromARGB(255, 89, 84, 84), width: 1),
              dropdownTitleTileBorderRadius: BorderRadius.circular(5),
              expandedIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black54,
              ),
              collapsedIcon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.black54,
              ),
              submitButton: Text('OK'),
              dropdownTitleTileTextStyle:
                  const TextStyle(fontSize: 14, color: Colors.black54),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.all(6),
              type: GFCheckboxType.basic,
              activeBgColor: Colors.green.withOpacity(0.5),
              inactiveBorderColor: Color.fromARGB(255, 158, 136, 136),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 13, 164, 28),
              ),
              child: const Text('Done'),
              onPressed: () async {
                //await afterLog();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            takeMealsAmountWidget(
                              meal: widget.meal,
                            )),
                    (route) => false);
              })
        ]),
      ),
    );
  }
}
