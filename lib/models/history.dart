class history {
  num? height=0.0, weight=0.0, BMI=0.0, PBF=0.0, PBW=0.0, preweight=0.0,totalweightlost=0.0;
 history.empty();
  history(this.height, this.weight,this.BMI, this.PBF, this.PBW, this.preweight,this.totalweightlost );

  factory history.fromJson(dynamic json) {
    return history(json["height"] as num, json["weight"] as num,
        json["BMI"] as num, json["PBF"] as num, json["PBW"] as num,
        json["preweight"] as num, json["totalweightlost"] as num
        );
  }
}
