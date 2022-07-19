class inbody {
  num? height=0.0, weight=0.0, BMI=0.0, PBF=0.0, PBW=0.0;
 inbody.empty();
  inbody(this.height, this.weight,this.BMI, this.PBF, this.PBW );

  factory inbody.fromJson(dynamic json) {
    return inbody(json["height"] as num, json["weight"] as num,
        json["BMI"] as num, json["PBF"] as num, json["PBW"] as num

        );
  }
}
