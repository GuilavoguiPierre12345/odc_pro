import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/widgets/categories_card/cardFeekback.dart';
import 'package:odc_pro/widgets/categories_card/form_builder.dart';
import 'package:odc_pro/widgets/dialogue/dialogue.dart';

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
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          // Container(
          //   child: FormBuilder(
          //     key: _formKey,
          //     child: Column(
          //       children: [
          //         InputFrom(
          //           titre: 'subjet',
          //           hin: 'votre sujet',
          //           nom: 'sujet',error: 'le sujet est obligatoire'),
          //           SizedBox(height: 25,),
          //         InputFrom(
          //           titre: 'feekback',
          //           hin: 'votre feekback',
          //           nom: 'feekback',error: 'le feekback est obligatoire'),
          //           SizedBox(height: 25,),
          //           GFButton(
          //             onPressed: (){
          //               if(_formKey.currentState!.saveAndValidate()){
          //                     print(_formKey.currentState!.value);
          //               }
          //           },
          //           textStyle: TextStyle(fontSize: 24),
          //           color: Color(0xFF33BBC5),
          //           text: "Envoyer feekback",
          //           fullWidthButton: true,
          //           size: GFSize.LARGE,
          //           )
          //       ],
          //     )),
          // ),
          Expanded(
            child: ListView(
                children: List.generate(10, (index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return create_dialogue();
                    },
                  );
                },
                child: createCardFeek(
                    image: "image.jpeg",
                    titre: "Appréciation",
                    subjet: "j'apprécie votre application",
                    date: "10:30"),
              );
            })),
          )
        ],
      ),
    );
  }
}
