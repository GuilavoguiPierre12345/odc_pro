import 'package:flutter/material.dart';


Widget createCardFeek({required String image,required String titre,required String subjet,required String date}){
  return Card(
    child: ListTile(
      
      title: Text("${titre}",style: TextStyle(fontSize: 24),),
      subtitle: Text("${subjet}",style: TextStyle(fontSize: 24),),
      trailing: Text("${date}"),
    ),
  );
}