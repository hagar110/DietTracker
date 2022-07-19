import 'package:firstgp/globals/globalFunctions.dart';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/screens/log_meals_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../layout/social_app/cubit/cubit.dart';

class PatientBehaviour extends StatelessWidget {
  String uId;
  String name;
  PatientBehaviour({Key? key, required this.uId, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<void>(
            future: SocialCubit.get(context).getPatientLoggedMeals(uId),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              List<Widget> children;
              if (snapshot.connectionState == ConnectionState.done) {
                children = <Widget>[
                  (loggedMeals.breakfast.length == 0)
                      ? const Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("no logged meals yet"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Here is what " +
                              name +
                              " logged through this week:"),
                        ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: loggedMeals.breakfast.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Day ' + (index + 1).toString()),
                            const SizedBox(
                              height: 20,
                            ),
                            getmeal(
                                "Breakfast",
                                loggedMeals.breakfast.length < index + 1
                                    ? "No Breakfast Logged"
                                    : loggedMeals.breakfast[index],
                                const Icon(Icons.breakfast_dining_outlined),
                                context,
                                loggedMeals.breakfast_daily_calories[index]),
                            const SizedBox(
                              height: 15,
                            ),
                            getmeal(
                                "Lunch",
                                loggedMeals.lunch.length < index + 1
                                    ? "No Lunch Logged"
                                    : loggedMeals.lunch[index],
                                const Icon(Icons.lunch_dining_outlined),
                                context,
                                loggedMeals.lunch_daily_calories[index]),
                            const SizedBox(
                              height: 15,
                            ),
                            getmeal(
                                "Dinner",
                                loggedMeals.dinner.length < index + 1
                                    ? "No Dinner Logged"
                                    : loggedMeals.dinner[index],
                                const Icon(Icons.dinner_dining),
                                context,
                                loggedMeals.dinner_daily_calories[index]),
                            const SizedBox(
                              height: 15,
                            ),
                            getmeal(
                                "Snacks",
                                loggedMeals.snacks.length < index + 1
                                    ? "No Snacks Logged"
                                    : loggedMeals.snacks[index],
                                const Icon(Icons.food_bank_outlined),
                                context,
                                loggedMeals.snacks_daily_calories[index]),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 1.0,
                              width: double.infinity,
                              color: Colors.black,
                            ),
                          ],
                        );
                      }),
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('no meals'),
                  )
                ];
                return const CircularProgressIndicator();
              } else {
                children = <Widget>[
                  Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),

                      ],
                    ),
                  )
                ];
              }
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: children,
                ),
              );
            }),
      ),
    );
  }
}

Widget getmeal(
        String title, String content, Icon icon, context, num calories) =>
    Container(
      color: Colors.white70,
      child: Column(children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(title + "   " + calories.round().toString() + "  calories"),
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
            ? Text(content, style: const TextStyle(fontSize: 15))
            : const Text("No Available Meals Yet"),
        const SizedBox(
          height: 10,
        )
      ]),
    );
