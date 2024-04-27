class LieuModel {
  String? id;
  String nomlieu;
  String ville;
  String quartier;
  String contact1;
  String contact2;

  LieuModel(
      { this.id,
      required this.nomlieu,
      required this.ville,
      required this.quartier,
      required this.contact1,
      required this.contact2});

  factory LieuModel.fromJson(Map<String, dynamic> json) {
    return LieuModel(
      nomlieu: json["nomlieu"] as String,
      ville: json["ville"] as String,
      quartier: json["quartier"] as String,
      contact1: json["contact1"] as String,
      contact2: json["contact2"] as String,
    );
  }

  // Map<String, dynamic> toJson() => {
  //   "nomlieu": nomlieu,
  //   "ville": ville,
  //   "quartier": quartier,
  //   "contact1": contact1,
  //   "contact2": contact2
  // };
}
