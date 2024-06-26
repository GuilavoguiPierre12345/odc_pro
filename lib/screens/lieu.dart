
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/screens/login.dart';
import 'package:odc_pro/services/lieu_service.dart';
import 'package:odc_pro/widgets/customCircularProgress.dart';
import 'package:odc_pro/widgets/lieuListItem.dart';

Widget lieuPage(BuildContext context, {required Function setState}) {
  setState(() {});
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
                    ),
                child: IconButton(
                    onPressed: () {
                      Get.offAll(LoginPage());
                      // Get.bottomSheet(lieuBottomSheet(typeAction: "add", context: context, setState: setState));
                    },
                    icon: const Icon(Icons.logout,size: 45,)),
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
          child: FutureBuilder(
              future: LieuService().allLocations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return customCircularProgress();
                } else if (snapshot.hasError) {
                  return customCircularProgress();
                } else {
                  dynamic lieux = snapshot.data;

                  return ListView(
                    shrinkWrap: true,
                    children: List.generate(snapshot.data!.length, (index) {
                      return lieuListItem(
                          index: index,
                          updateState: setState,
                          lieu: lieux[index]);
                    }),
                  );
                }
              }))
    ],
  );
}
