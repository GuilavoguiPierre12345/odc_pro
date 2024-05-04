class LieuModel {
  String? id;
  String nomlieu;
  String ville;
  String quartier;
  String contact_1;
  String contact_2;
  double? p_long;
  double? p_lat;
  List<Map<String, dynamic>> horaires;

  LieuModel(
      {this.id,
      required this.nomlieu,
      required this.ville,
      required this.quartier,
      required this.contact_1,
      required this.contact_2,
      required this.horaires});

  factory LieuModel.fromJson(Map<String, dynamic> json) {
    return LieuModel(
      nomlieu: json["nomlieu"] as String,
      ville: json["ville"] as String,
      quartier: json["quartier"] as String,
      contact_1: json["contact_1"] as String,
      contact_2: json["contact_2"] as String,
      horaires: json["horaires"],
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
