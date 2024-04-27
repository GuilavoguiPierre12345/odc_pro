import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/widgets/bottomSheetContent.dart';
import 'package:odc_pro/widgets/categoryListItem.dart';
import 'package:odc_pro/widgets/lieuBottomSheet.dart';
import 'package:odc_pro/widgets/lieuListItem.dart';

Widget lieuPage(BuildContext context, {required Function setState}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 6,
        decoration: const BoxDecoration(color: Color(0xFF33BBC5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Ajouter Lieu",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: Colors.white, width: 2.0)),
                child: IconButton(
                    onPressed: () {
                      Get.bottomSheet(lieuBottomSheet(typeAction: "add"));
                    },
                    icon: const Icon(Icons.add)),
              ),
            ),
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Liste des Lieux",
          style: TextStyle(color: Color(0xFF33BBC5), fontSize: 22),
        ),
      ),
      Expanded(
        child: ListView(
          shrinkWrap: true,
          children: List.generate(50, (index) {
            return lieuListItem(index: index, updateState: setState);
          }),
        ),
      )
    ],
  );
}
