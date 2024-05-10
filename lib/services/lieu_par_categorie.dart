import 'package:cloud_firestore/cloud_firestore.dart';

class LieuParCategorie {
  // Future<Map<String, dynamic>> lieuParCategorie() async {
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> lieux =
  //       await LieuService().allLocations();

  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> categories =
  //       await CategorieService().allCategories();

  //   List<Map<String, dynamic>> lieuCategories = [];
  //   Set<QueryDocumentSnapshot<Map<String, dynamic>>> categoriesSet = {};
  //   for (var cat in categories) {
  //     for (var lieu in lieux) {
  //       if (lieu.data()["category"] == cat.id) {
  //         categoriesSet.add(cat);
  //         lieuCategories.add(lieu.data());
  //         // print("cat : ${cat.data()} lieu : ${lieu.data()}");
  //       }
  //     }
  //   }
  //   return {"lieux": lieuCategories, "categories": categoriesSet};
  // }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      lieuParCategorie(String categorieId) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocuments = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("lieu").where("cagory",isEqualTo: categorieId).get();

      for (var doc in querySnapshot.docs) {
        queryDocuments.add(doc);
      }
      return queryDocuments;
    } catch (e) {
      print("Error retrieving categories: $e");
      return []; // ou une autre action en cas d'erreur
    }
  }
}
