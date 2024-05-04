import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/screens/pagetest.dart';
import 'package:odc_pro/widgets/bottomSheetContent.dart';

Widget lieuListItem(
    {required int index,
    required Function updateState,
    required QueryDocumentSnapshot<Map<String, dynamic>> lieu}) {
  return Card.outlined(
    elevation: 7.0,
    child: Dismissible(
      onDismissed: (direction) {
        Get.to(() => PageTest(
              typeAction: "maj",
              lieu: lieu,
            ));
        // Get.bottomSheet(addAdminBottomSheet(typeAction: "maj"));
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lieu : ${lieu["nomLieu"]} | Ville : ${lieu["ville"]} | Quartier : ${lieu["quartier"]}",
                style: TextStyle(fontSize: 26),
              ),
              Text(
                  "Contact 1 : ${lieu["contact1"]} | Contact 2 : ${lieu["contact2"]}",
                  style: const TextStyle(fontSize: 26)),
            ],
          ),
          subtitle: Text(
              "Coords : Longitude : ${lieu["longitude"]} - Latatide : ${lieu["latitude"]}",
              style: const TextStyle(fontSize: 20)),
        ),
      ),
    ),
  );
}
