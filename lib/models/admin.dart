class AdminModel {
  String? id;
  String nomcomplet;
  String profession;
  String contact;
  String password;
  AdminModel(
      {this.id,
      required this.nomcomplet,
      required this.profession,
      required this.contact,
      required this.password});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
        nomcomplet: json["nomcomplet"] ,
        profession: json["profession"] ,
        contact: json["contact"],
        password: json['password']);
  }

  // Map<String, dynamic> toJson() => {
  //       "nomcomplet": nomcomplet,
  //       "profession": profession,
  //       "contact": contact,
  // };
}
