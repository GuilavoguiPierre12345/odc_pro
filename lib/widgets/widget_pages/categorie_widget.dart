import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/services/categorie_service.dart';
import 'package:odc_pro/services/lieu_par_categorie.dart';
import 'package:odc_pro/widgets/categories_card/cat.dart';
import 'package:odc_pro/widgets/customCarousel.dart';
import 'package:odc_pro/widgets/customCircularProgress.dart';

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
                  future: LieuParCategorie().lieuParCategorie(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return customCircularProgress();
                    } else if (snapshot.hasError) {
                      return customCircularProgress();
                    } else {
                      List<Map<String, dynamic>> lieuCat = snapshot.data ?? [];
                      List cat = [];

                      return SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                lieuCat.length,
                                (index) => create_categories(
                                    lieu: lieuCat[index]["lieu"],
                                    context: context,
                                    catObject: lieuCat[index]["categorie"],
                                    cat: lieuCat[index]["categorie"]
                                        ["categorie"]))),
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
