import 'package:flutter/material.dart';

class Dish {
  String Category = "", Name = "";
  double Calories = 0.0, Carbohydrates = 0.0, Protein = 0.0, Fat = 0.0;
  int Meal = 0;

  Dish(this.Category, this.Name, this.Calories, this.Carbohydrates,
      this.Protein, this.Fat, this.Meal);
  Dish.empty() {}
}
