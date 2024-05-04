import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/models/categorie.dart';
import 'package:odc_pro/widgets/categoryBottomSheet.dart';

Widget categoryListItem(
    {required int index,
    required Function updateState,
    required QueryDocumentSnapshot<Map<String, dynamic>> categorie}) {
  return Card.outlined(
    elevation: 7.0,
    child: Dismissible(
      onDismissed: (direction) {
        Get.defaultDialog(
            title: "Modification categorie",
            titleStyle: const TextStyle(color: Colors.white),
            backgroundColor: const Color(0xFF33BBC5),
            titlePadding: const EdgeInsets.only(top: 8.0),
            contentPadding: const EdgeInsets.all(0.0),
            content:
                categoryBottomSheet(typeAction: "maj", categorie: categorie));
      },
      background: Container(
        color: const Color(0xFF33BBC5),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      key: Key("$index"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(categorie["categorie"]),
        ),
      ),
    ),
  );
}
