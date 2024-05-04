import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/widgets/categories_card/form_builder.dart';


class FeekBack extends StatefulWidget {
  const FeekBack({super.key});

  @override
  State<FeekBack> createState() => _FeekBackState();
}

class _FeekBackState extends State<FeekBack>
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

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 80,
          width: double.infinity,
          decoration: const BoxDecoration(color: Color(0xFF33BBC5)),
          child: const Text(
            "Feedback",
            style: TextStyle(fontSize: 35, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  InputFrom(
                      titre: 'subjet',
                      keyBoard: TextInputType.text,
                      hin: 'votre sujet',
                      nom: 'sujet',
                      error: 'le sujet est obligatoire'),
                  const SizedBox(
                    height: 25,
                  ),
                  InputFrom(
                      titre: 'feekback',
                      keyBoard: TextInputType.multiline,
                      hin: 'votre feekback',
                      nom: 'contenu',
                      error: 'le feekback est obligatoire'),
                  const SizedBox(
                    height: 25,
                  ),
                  GFButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        envoyerUtilisateur(_formKey.currentState!.value);
                      }
                    },
                    textStyle: const TextStyle(fontSize: 24),
                    color: const Color(0xFF33BBC5),
                    text: "Envoyer feekback",
                    fullWidthButton: true,
                    size: GFSize.LARGE,
                  )
                ],
              )),
        ),
        // Expanded(
        //   child: ListView(
        //       children: List.generate(10, (index) {
        //     return GestureDetector(
        //       onTap: () {
        //         showDialog(
        //           context: context,
        //           builder: (context) {
                    // return create_dialogue();
        //           },
        //         );
        //       },
        //       child: createCardFeek(
        //           image: "image.jpeg",
        //           titre: "Appréciation",
        //           subjet: "j'apprécie votre application",
        //           date: "10:30"),
        //     );
        //   })),
        // )
      ],
    );
  }
}

Future<void> envoyerUtilisateur(data) async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    Get.defaultDialog(
      title: '',
      content: const CircularProgressIndicator(),
    );
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('feedback').add(data).then((value) {
        Get.snackbar('Send', 'Send successfull',
            backgroundColor: const Color(0xFF33BBC5));
        Get.back();
        return true;
      }).catchError((error) {
        Get.back();
        print('Erreur lors de l\'ajout du document : $error');
        return false;
      });
    } on TimeoutException {
      Get.defaultDialog(
          title: 'Error',
          content: Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              "Timeout...",
              style: TextStyle(color: Colors.red),
            ),
          ));
      
    }
    
  }else{
    Get.snackbar("Internet error", "INTERNET ERROR");
  }
}
