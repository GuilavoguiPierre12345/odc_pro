import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/widgets/widget_pages/cagegorie_detail.dart';

class Detail_Categorie_detail extends StatefulWidget {
  const Detail_Categorie_detail({super.key});

  @override
  State<Detail_Categorie_detail> createState() => _Detail_Categorie_detailState();
}

class _Detail_Categorie_detailState extends State<Detail_Categorie_detail>
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
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: (){
        //   Get.off(Categorie_detail());
        // }, icon: Icon(Icons.chevron_left,size: 40,)),
      ),
      body: Container(
      padding: EdgeInsets.all(10),
      child: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height/1.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Nom :",style: TextStyle(fontSize: 24,color: Color(0xFF33BBC5)),),
                  Text("Telephone :",style: TextStyle(fontSize: 24,color: Color(0xFF33BBC5)),),
                  Text("Distance :",style: TextStyle(fontSize: 24,color: Color(0xFF33BBC5)),),
                ],
              ))
      
            ],
      ),
          ),
    );
  }
}