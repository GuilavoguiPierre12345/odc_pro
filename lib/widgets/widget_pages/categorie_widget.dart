import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:odc_pro/widgets/categories_card/cat.dart';



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
      padding: EdgeInsets.all(20),
      child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFF33BBC5),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
          
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   create_categories(titre: "Restaurant", cont: context, image: "image.jpeg",cat: "Restaurant"),
                   
                   create_categories(titre: "Restaurant", cont: context, image: "image.jpeg",cat: "Boite de nuit"),
                     
                  ],
                            ),
              ))
            
          ],
      ),
    );
  }
}