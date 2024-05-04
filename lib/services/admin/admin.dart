import 'package:cloud_firestore/cloud_firestore.dart';

class Admim {
  Map<String, dynamic> data = {} ;
  void envoyerUtilisateur(data) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Ajouter un nouveau document dans la collection "utilisateurs"
    await firestore.collection('admin').add(data).then((value) {
      print('Document ajouté avec l\'ID : ${value.id}');
    }).catchError((error) {
      print('Erreur lors de l\'ajout du document : $error');
    });
  }
}
