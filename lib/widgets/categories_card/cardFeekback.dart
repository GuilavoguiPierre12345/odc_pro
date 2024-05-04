import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/widgets/dialogue/dialogue.dart';

Widget createCardFeek({required Map<String, dynamic>? user}) {
  return GestureDetector(
    onTap: () {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(0),
        title: '',
        titlePadding: EdgeInsets.all(0),
        content: create_dialogue(user: user)

      );
      
      
    },
    child: Card(
      elevation: 3,
      child: ListTile(
        title: Text(
          "${user!['sujet']}",
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${user['contenu']}",
          style: const TextStyle(
            fontSize: 22,
          ),
          softWrap: false,
        ),
        // trailing: Text("${date}"),
      ),
    ),
  );
}
