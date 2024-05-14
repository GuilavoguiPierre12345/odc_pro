import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/services/categorie_service.dart';
import 'package:odc_pro/services/lieu_par_categorie.dart';
import 'package:odc_pro/widgets/categories_card/cat.dart';
import 'package:odc_pro/widgets/customCarousel.dart';
import 'package:odc_pro/widgets/customCircularProgress.dart';
import 'package:odc_pro/widgets/widget_pages/cagegorie_detail.dart';
import 'package:odc_pro/widgets/widget_pages/detail_categorie_detail.dart';

class Categorie_Widget extends StatefulWidget {
  const Categorie_Widget({super.key});

  @override
  State<Categorie_Widget> createState() => _Cagorie_WidgetState();
}

class _Cagorie_WidgetState extends State<Categorie_Widget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    final List<String> imageList = [
      "assets/images/carousel-1.avif",
      "assets/images/carousel-2.avif",
      "assets/images/carousel-3.avif",
      "assets/images/carousel-4.avif",
      "assets/images/carousel-5.avif",
    ];
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFF33BBC5),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/carousel-5.avif",
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 42,
                    child: Text(
                      "SE-LO APP",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF33BBC5)),
                    ),
                  )
                ],
              )
              // child: customCarousel(setState: setState, context: context),
              ),
          Expanded(
              child: FutureBuilder(
                  future: CategorieService().allUniqueCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return customCircularProgress();
                    } else if (snapshot.hasError) {
                      return customCircularProgress();
                    } else {
                      dynamic uniqueCat = snapshot.data;

                      if (snapshot.hasData) {
                        return GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          scrollDirection: Axis.vertical,
                          children: List.generate(uniqueCat.length, (index) {
                            return GestureDetector(
                                onTap: () {
                                  Get.to(Categorie_detail(
                                    categorie: uniqueCat[index]
                                  ));
                                },
                                child: Container(
                                    alignment: Alignment.bottomLeft,
                                    margin: const EdgeInsets.only(
                                        right: 5, bottom: 10),
                                    width:
                                        MediaQuery.sizeOf(context).width / 2 +
                                            30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/carousel-2.avif"),
                                            fit: BoxFit.cover,
                                            opacity: .5),
                                        color: const Color.fromARGB(
                                                181, 51, 187, 197)
                                            .withOpacity(.8),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      height: 70,
                                      padding: const EdgeInsets.only(left: 7),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.4),
                                          borderRadius: const BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            uniqueCat[index]["categorie"],
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )));
                          }),
                        );
                      }
                      return Center(child: Text("LIST N/A"));
                    }
                  }))
        ],
      ),
    );
  }
}
