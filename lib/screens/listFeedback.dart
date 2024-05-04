import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/screens/login.dart';
import 'package:odc_pro/widgets/categories_card/cardFeekback.dart';



Widget listFeedBack(){
  return Column(
    
    children: [
      Container(
        padding: const EdgeInsets.only(left: 15),
        width: double.infinity,
        alignment: Alignment.center,
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFF33BBC5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                const Text('Liste des FeedBack',style: TextStyle(fontSize: 30,color: Colors.white,),textAlign: TextAlign.center,),
                IconButton(
                      onPressed: () {
                        Get.off(LoginPage());
                      },
                      icon: const Icon(Icons.logout),style: const ButtonStyle(iconSize:MaterialStatePropertyAll(40),),),
          ],
        ) 
      ),
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("feedback").snapshots(),
            builder: (context,snap){
                 if(snap.hasError){
              return const Center(child: Text("Error"),);
            }
            if(snap.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            List<Map<String,dynamic>> feed=[];
            snap.data!.docs.forEach((element) {
              feed.add(element.data() as Map<String,dynamic>);
            });
            return ListView.builder(
              itemCount: feed.length,
              itemBuilder: (context,index){
                return createCardFeek(user: feed[index]);

              }
              
              
              );
            }))
    ],
  );
}