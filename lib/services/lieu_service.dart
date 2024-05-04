import 'package:cloud_firestore/cloud_firestore.dart';

class LieuService {
  //ajouter une categorie de lieu
  Future<void> addLieu(
      Map<String, dynamic> lieuInfo, Map<String, dynamic> positionInfo) async {
    Map<String, dynamic> lieuRealInfo = {};
    lieuRealInfo.addAll(lieuInfo);
    lieuRealInfo.addAll(positionInfo);
    await FirebaseFirestore.instance.collection("lieu").add(lieuRealInfo);
  }

  Future<void> updateLieu(
      String docId, Map<String, dynamic> newlieu,Map<String, dynamic> positionInfo) async {
    await FirebaseFirestore.instance
        .collection("lieu")
        .doc(docId)
        .update(newlieu);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      allLocations() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocuments = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("lieu").get();

      for (var doc in querySnapshot.docs) {
        queryDocuments.add(doc);
      }
      return queryDocuments;
    } catch (e) {
      print("Erreur de recuperation des lieux : $e");
      return []; // ou une autre action en cas d'erreur
    }
  }
}
