import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odc_pro/models/categorie.dart';

class CategorieService {
  //ajouter une categorie de lieu
  Future<void> addCategorie(Map<String, dynamic> categorie) async {
    await FirebaseFirestore.instance.collection("categories").add(categorie);
  }

  Future<void> updateCategorie(
      String docId, Map<String, dynamic> newcategorie) async {
    await FirebaseFirestore.instance
        .collection("categories")
        .doc(docId)
        .update(newcategorie);
  }

  Future<List<Map<String, dynamic>>> dropdownList() async {
    List<Map<String, dynamic>> categories = [];
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((snapshots) {
          for (var doc in snapshots.docs) {
            categories.add({"key": doc.id, "value": doc.data()});
          }
        });
    return categories;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      allCategories() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocuments = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("categories").get();

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
