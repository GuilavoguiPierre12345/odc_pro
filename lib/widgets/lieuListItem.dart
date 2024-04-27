import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/widgets/bottomSheetContent.dart';

Widget lieuListItem({required int index, required Function updateState}) {
  return Card.outlined(
    elevation: 7.0,
    child: Dismissible(
      onDismissed: (direction) {
        Get.bottomSheet(addAdminBottomSheet(typeAction: "maj"));
      },
      background: Container(
        color: Color(0xFF33BBC5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
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
