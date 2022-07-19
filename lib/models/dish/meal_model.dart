class meal {
  String lastFetched = "";
  String lunch, breakfast, dinner, snacks, id;
  meal(this.id, this.breakfast, this.lunch, this.dinner, this.snacks,
      this.lastFetched);
  factory meal.fromJson(dynamic json) {
    return meal(json["id"], json["breakfast"], json["lunch"], json["dinner"],
        json["snacks"], json["lastFetched"]);
  }
}
class LoggedMeal {
  List<String>  breakfast,lunch, dinner, snacks;
  List<num> breakfast_daily_calories, lunch_daily_calories,dinner_daily_calories, snacks_daily_calories ;
  LoggedMeal( this.breakfast, this.lunch, this.dinner, this.snacks,
      this.breakfast_daily_calories, this.lunch_daily_calories, this.dinner_daily_calories, this.snacks_daily_calories);
  factory LoggedMeal.fromJson(dynamic json) {
    return LoggedMeal(json["breakfast"], json["lunch"], json["dinner"], json["snacks"],
        json["breakfast daily calories"],
        json["lunch daily calories"],
        json["dinner daily calories"],
        json["snacks daily calories"]);
  }
}
