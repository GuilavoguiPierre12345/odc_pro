import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/widgets/customCircularProgress.dart';
import 'package:odc_pro/widgets/widget_pages/cagegorie_detail.dart';
import 'package:odc_pro/widgets/widget_pages/detail_categorie_detail.dart';

Widget create_categories(
    {required Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
        lieuList,
    required BuildContext context,
    required String cat}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 9.0, bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cat,
              style: const TextStyle(fontSize: 22, color: Color(0xFF33BBC5)),
            ),
            GestureDetector(
              onTap: () {
                Get.to(const Categorie_detail());
              },
              child: const Text(
                "voir plus...",
                style: TextStyle(fontSize: 22, color: Color(0xFF33BBC5)),
              ),
            )
          ],
        ),
      ),
      Container(
        child: FutureBuilder(
            future: lieuList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return customCircularProgress();
              } else if (snapshot.hasError) {
                return customCircularProgress();
              } else {
                List<QueryDocumentSnapshot<Map<String, dynamic>>>? lieux =
                    snapshot.data;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Row(
                      children: List.generate(snapshot.data!.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(const Detail_Categorie_detail());
                          },
                          child: Container(
                              alignment: Alignment.bottomLeft,
                              margin:
                                  const EdgeInsets.only(right: 5, bottom: 10),
                              height: MediaQuery.sizeOf(context).width / 2,
                              width: MediaQuery.sizeOf(context).width / 2 + 30,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/image.jpeg"),
                                      fit: BoxFit.cover,
                                      opacity: .5),
                                  color: const Color.fromARGB(181, 51, 187, 197)
                                      .withOpacity(.8),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.4),
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(15))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      lieux![index]["nomLieu"],
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                    Text(
                                      lieux[index]["ville"],
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }),
                    ),
                  ),
                );
              }
            }),
      ),
    ],
  );
}
