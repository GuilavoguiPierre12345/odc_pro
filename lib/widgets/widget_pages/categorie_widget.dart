import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:odc_pro/services/categorie_service.dart';
import 'package:odc_pro/services/lieu_par_categorie.dart';
import 'package:odc_pro/widgets/categories_card/cat.dart';
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
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: const BoxDecoration(
                color: Color(0xFF33BBC5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          Expanded(
              child: FutureBuilder(
                  future: CategorieService().allCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return customCircularProgress();
                    } else if (snapshot.hasError) {
                      return customCircularProgress();
                    } else {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>? categorie = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            snapshot.data!.length,
                            (index) => create_categories(
                                lieuList: LieuParCategorie().lieuParCategorie(categorie![index].id),
                                context: context,
                                cat: categorie[index]["categorie"]),
                          ),
                        ),
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
