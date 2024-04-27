import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/widgets/categoryBottomSheet.dart';

Widget categoryListItem({required int index, required Function updateState}) {
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
            content: categoryBottomSheet(typeAction: "maj"));
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
      child: const ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("assets/images/bg.avif"),
        ),
        title: Text("Institut Technologies YabTech"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("Ecode de code")],
        ),
      ),
    ),
  );
}
