import 'package:flutter/material.dart';

Widget create_dialogue({required Map<String, dynamic>? user}) {
  return AlertDialog(
    icon: Icon(Icons.feedback,size: 50,),
    contentPadding: EdgeInsets.all(0),
    title: const Text(
      "Feedback",
      style:TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 30),
    ),
    content: SizedBox(
      height: 400,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          "${user!['contenu']}",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    ),
  );
}
