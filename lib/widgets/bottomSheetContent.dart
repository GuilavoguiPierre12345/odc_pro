import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/screens/profil.dart';
import 'package:odc_pro/widgets/input.dart';

class AdminBottonSheet extends StatefulWidget {
  AdminBottonSheet({super.key, required this.typeAction,this.user});

  late String typeAction;
  late Map? user;
  bool isLogin = false;

  @override
  State<AdminBottonSheet> createState() => _AdminBottonSheetState();
}

class _AdminBottonSheetState extends State<AdminBottonSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final formKey = GlobalKey<FormBuilderState>();
  bool? isLogin = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(231, 51, 187, 197),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: formKey,
            child: ListView(
              children: [
                inputWidget(
                    typeAction: widget.typeAction,
                    defaultValue: "${widget.user?['nomcomplet']}",
                    inputName: "nomcomplet",
                    inputLabel: "Nom complet",
                    errorText: "Thi field is required",
                    prefixIcon: Icons.person),
                inputWidget(
                    typeAction: widget.typeAction,
                    defaultValue: "${widget.user?['password']}",
                    inputName: "password",
                    obs: true,
                    inputLabel: "Mot de passe",
                    errorText: "Thi field is required",
                    prefixIcon: Icons.lock),
                inputWidget(
                    typeAction: widget.typeAction,
                    defaultValue: "${widget.user?['profession']}",
                    inputName: "profession",
                    inputLabel: "Profession",
                    errorText: "This field is required",
                    prefixIcon: Icons.work),
                inputWidget(
                    typeAction: widget.typeAction,
                    defaultValue: "${widget.user?['contact']}",
                    inputName: "contact",
                    inputLabel: "Contact",
                    errorText: "This field is required",
                    prefixIcon: Icons.phone),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GFButton(
                    size: GFSize.LARGE,
                    fullWidthButton: true,
                    type: GFButtonType.outline,
                    onPressed: () {
                      if (formKey.currentState!.saveAndValidate()) {
                        if (widget.typeAction == "add") {
                          envoyerUtilisateur(formKey.currentState!.value);
                          Get.back();
                           
                        } else {
                          obtenirIdDocument(formKey.currentState!.value,
                              "${widget.user!['contact']}");
                              Get.back(); 
                        }

                        setState(() {
                          const ProfilPage();
                        });
                        // Get.to(const IndexPage());
                      }
                    },
                    color: Colors.white,
                    child: Text(
                      widget.typeAction == "add" ? "Ajouter" : "Mise a jour",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

// Widget addAdminBottomSheet({required String typeAction,Map? user}) {
//   final formKey = GlobalKey<FormBuilderState>();
//   bool? isLogin;

//   return Container(
//       decoration: const BoxDecoration(
//           color: Color.fromARGB(231, 51, 187, 197),
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FormBuilder(
//           key: formKey,
//           child: ListView(
//             children: [
//               inputWidget(
//                   typeAction: typeAction,
//                   defaultValue: "${user!['nomcomplet']}",
//                   inputName: "nomcomplet",
//                   inputLabel: "Nom complet",
//                   errorText: "Thi field is required",
//                   prefixIcon: Icons.person),
//                inputWidget(
//                   typeAction: typeAction,
//                   defaultValue: "${user!['password']}",
//                   inputName: "password",
//                   obs: true,
//                   inputLabel: "Mot de passe",
//                   errorText: "Thi field is required",
//                   prefixIcon: Icons.lock),
//               inputWidget(
//                   typeAction: typeAction,
//                   defaultValue: "${user!['profession']}",
//                   inputName: "profession",
//                   inputLabel: "Profession",
//                   errorText: "This field is required",
//                   prefixIcon: Icons.work),
//               inputWidget(
//                   typeAction: typeAction,
//                   defaultValue: "${user!['contact']}",
//                   inputName: "contact",
//                   inputLabel: "Contact",
//                   errorText: "This field is required",
//                   prefixIcon: Icons.phone),
//               Padding(
//                 padding:  EdgeInsets.all(8.0),
//                 child: GFButton(
//                   size: GFSize.LARGE,
//                   fullWidthButton: true,
//                   type: GFButtonType.outline,
//                   onPressed: () {
//                     if (formKey.currentState!.saveAndValidate()) {

//                       if (typeAction == "add") {

//                         envoyerUtilisateur(formKey.currentState!.value);
//                         formKey.currentState!.reset();

//                       } else {
//                         if(isLogin!){
//                             const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                         }else{

//                             SetState((){});
//                                obtenirIdDocument(formKey.currentState!.value, "${user['contact']}")
//                         }

//                       }
//                       // Get.to(const IndexPage());
//                     }
//                   },
//                   color: Colors.white,
//                   child: Text(
//                     typeAction == "add" ? "Ajouter" : "Mise a jour",
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ));
// }
//methode pour l'ajout des données
Future<bool> envoyerUtilisateur(data) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference admin = FirebaseFirestore.instance.collection('admin');
    QuerySnapshot query =
        await admin.where('contact', isEqualTo: data['contact']).get();
    if (query.docs.isEmpty) {
      await firestore.collection('admin').add(data).then((value) {
        Get.snackbar('Send', 'Send successfull',
            backgroundColor: const Color(0xFF33BBC5));
        return true;
      }).catchError((error) {
        print('Erreur lors de l\'ajout du document : $error');
        return false;
      });
    } else {
      Get.defaultDialog(
          title: 'Doublons',
          content: Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              "number exists",
              style: TextStyle(color: Colors.red, fontSize: 26),
            ),
          ));
      return false;
    }
  } on SocketException {
    Get.defaultDialog(
        title: 'Error',
        content: Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            "Error net...",
            style: TextStyle(color: Colors.red),
          ),
        ));
  } on TimeoutException {
    Get.defaultDialog(
        title: 'Error',
        content: Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            "Timeout...",
            style: TextStyle(color: Colors.red),
          ),
        ));
    return false;
  }
  return true;
}
//methode pour modification des données

void obtenirIdDocument(Map user, String valeurUnique) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('admin')
        .where('contact', isEqualTo: valeurUnique)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String documentId = querySnapshot.docs.first.id;
      CollectionReference utilisateurs =
          FirebaseFirestore.instance.collection('admin');

      await utilisateurs
          .doc(documentId)
          .set(user, SetOptions(merge: true))
          .then((value) {
        Get.snackbar('Update', 'Update successfull',
            backgroundColor: const Color(0xFF33BBC5));

        
      });
    }
  } on SocketException{
    
    Get.defaultDialog(
        title: 'Error',
        content: Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            "Error net...",
            style: TextStyle(color: Colors.red),
          ),
        ));
  } on TimeoutException{
    
    Get.defaultDialog(
        title: 'Error',
        content: Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            "Timeout ...",
            style: TextStyle(color: Colors.red),
          ),
        ));
  }
  
  catch (e) {
    Get.snackbar('Error', e.toString());
  }
}
