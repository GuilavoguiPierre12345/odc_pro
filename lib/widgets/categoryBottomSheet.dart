import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/services/categorie_service.dart';
import 'package:odc_pro/widgets/input.dart';

Widget categoryBottomSheet(
    {required String typeAction,
    QueryDocumentSnapshot<Map<String, dynamic>>? categorie}) {
  final formKey = GlobalKey<FormBuilderState>();

  return Container(
      height: 180,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                inputWidget(
                    typeAction: typeAction,
                    defaultValue:
                        categorie!= null ? categorie['categorie'] : '',
                    inputName: "categorie",
                    inputLabel: "Categorie du lieu",
                    errorText: "Thi field is required",
                    prefixIcon: Icons.category),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GFButton(
                    size: GFSize.LARGE,
                    fullWidthButton: true,
                    type: GFButtonType.outline,
                    onPressed: () {
                      if (formKey.currentState!.saveAndValidate()) {
                        if (typeAction == "add") {
                          // Add the form data to remote database
              
                          CategorieService()
                              .addCategorie(formKey.currentState!.value)
                              .then((value) => {Get.back()})
                              .then((value) {
                            Get.snackbar("ajout d'une categorie de lieu",
                                "Categorie ajouter avec success !",
                                colorText: Colors.white,
                                backgroundColor: const Color(0xFF33BBC5),
                                snackPosition: SnackPosition.BOTTOM);
                          });
                        } else {
                          CategorieService()
                              .updateCategorie(
                                  categorie!.id, formKey.currentState!.value)
                              .then((value) => {Get.back()})
                              .then((value) {
                            Get.snackbar("mise a jour",
                                "Categorie mise a jour avec success !",
                                colorText: Colors.white,
                                backgroundColor: const Color(0xFF33BBC5),
                                snackPosition: SnackPosition.BOTTOM);
                          });
                        }
                        // Get.to(const IndexPage());
                      }
                    },
                    color: Colors.white,
                    child: Text(
                      typeAction == "add" ? "Ajouter" : "Mise a jour",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
}
