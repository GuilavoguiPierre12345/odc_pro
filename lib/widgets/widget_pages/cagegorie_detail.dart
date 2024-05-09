import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/widgets/widget_pages/detail_categorie_detail.dart';

class Categorie_detail extends StatefulWidget {
  const Categorie_detail({super.key});

  @override
  State<Categorie_detail> createState() => _Categorie_detailState();
}

// ignore: camel_case_types
class _Categorie_detailState extends State<Categorie_detail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Map<dynamic,dynamic> data={};
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
        // leading: IconButton(onPressed: (){
        //   Get.to(MyApp());
        // }, icon: Icon(Icons.chevron_left,size: 40,))
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          scrollDirection: Axis.vertical,
          children: List.generate(10, (index){
            return GestureDetector(
              onTap: () {
                Get.to(Detail_Categorie_detail(dataAll: data,));
              },
              child: Container(
                    color: Colors.red,
              ),
            );
          }),
        ),
      )
      
        
    );
  }
}