import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/services/lieu_service.dart';
import 'package:odc_pro/widgets/customCircularProgress.dart';
import 'package:odc_pro/widgets/widget_pages/detail_categorie_detail.dart';

class Categorie_detail extends StatefulWidget {
  Categorie_detail({super.key, required this.categorie});
  dynamic categorie;

  @override
  State<Categorie_detail> createState() => _Categorie_detailState();
}

// ignore: camel_case_types
class _Categorie_detailState extends State<Categorie_detail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Map<dynamic, dynamic> data = {};
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Categorie : ${widget.categorie["categorie"]}",
              style: TextStyle(
                  fontSize: 24, color: Color.fromARGB(255, 34, 45, 172))),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
              future: LieuService().lieuParCategorie(widget.categorie.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  customCircularProgress();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  customCircularProgress();
                }
                dynamic lieux = snapshot.data;
                if (snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    return GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      scrollDirection: Axis.vertical,
                      children: List.generate(lieux.length, (index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(Detail_Categorie_detail(
                                lieu: lieux[index],categorie: widget.categorie["categorie"],
                              ));
                            },
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                margin:
                                    const EdgeInsets.only(right: 5, bottom: 10),
                                width:
                                    MediaQuery.sizeOf(context).width / 2 + 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/carousel-1.avif"),
                                        fit: BoxFit.cover,
                                        opacity: .5),
                                    color:
                                        const Color.fromARGB(181, 51, 187, 197)
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lieux[index]["nomLieu"],
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                        lieux[index]["ville"],
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      )
                                    ],
                                  ),
                                )));
                      }),
                    );
                  } else {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/empty_list.jfif"))),
                        child: Text(
                          "LISTE VIDE POUR L'INSTANT",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.brown,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ));
                  }
                }
                return Center(child: customCircularProgress());
              }),
        ));
  }
}
