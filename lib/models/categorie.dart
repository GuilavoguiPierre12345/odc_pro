class CategorieModel {
  String? id;
  String categorie;

  CategorieModel({this.id, required this.categorie});

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
    return CategorieModel(
      categorie: json["categorie"] as String,
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "categorie": categorie,
  //     };
}
