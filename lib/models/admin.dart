class AdminModel {
  String? id;
  String nomcomplet;
  String profession;
  String contact;

  AdminModel(
      {this.id,
      required this.nomcomplet,
      required this.profession,
      required this.contact});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
        nomcomplet: json["nomcomplet"] as String,
        profession: json["profession"] as String,
        contact: json["contact"]);
  }

  // Map<String, dynamic> toJson() => {
  //       "nomcomplet": nomcomplet,
  //       "profession": profession,
  //       "contact": contact,
  // };
}
