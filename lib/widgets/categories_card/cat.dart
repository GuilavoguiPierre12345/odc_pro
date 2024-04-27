import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/widgets/widget_pages/cagegorie_detail.dart';
import 'package:odc_pro/widgets/widget_pages/detail_categorie_detail.dart';

Widget create_categories({required String titre,required BuildContext cont,required String image,required String cat}){
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(cat,style: TextStyle(fontSize: 22,color: Color(0xFF33BBC5)),),
          GestureDetector(
            onTap: () {
              Get.to(Categorie_detail());
            },
            child: Text("Voir plus...",style: TextStyle(fontSize: 22,color: Color(0xFF33BBC5)),),
          )
          

        ],
      ),
      Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
            children: List.generate(5, (index){
            return GestureDetector(
              onTap: () {
                Get.to(Detail_Categorie_detail());

              },
              child: Container(
                
                alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(right: 5,bottom: 10),
                        height: MediaQuery.sizeOf(cont).width/2,
                        width: MediaQuery.sizeOf(cont).width/2+30,
              decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/${image}"),fit: BoxFit.cover,opacity: .5),
              color: Color.fromARGB(181, 51, 187, 197).withOpacity(.8),
              
              borderRadius: BorderRadius.all(Radius.circular(15))
              ),child: Container(
                alignment: Alignment.bottomLeft,
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.4),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(15))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(titre,style: TextStyle(fontSize: 22,color: Colors.white),),
                        Text(titre,style: TextStyle(fontSize: 22,color: Colors.white),)
                      ],
                ),
              )),
            );
          }),
            ),
          ),
        
         
        ),
        
      ),
    ],
  );
}

