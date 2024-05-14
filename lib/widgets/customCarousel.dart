import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

Widget customCarousel(
    {required Function setState, required BuildContext context}) {
  final List<String> imageList = [
    "assets/images/carousel-1.avif",
    "assets/images/carousel-2.avif",
    "assets/images/carousel-3.avif",
    "assets/images/carousel-4.avif",
    "assets/images/carousel-5.avif",
  ];
  return GFCarousel(
    autoPlay: true,
    autoPlayCurve: Curves.easeInOut,
    items: imageList.map(
      (url) {
        return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.asset(
              url,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        );
      },
    ).toList(),
    onPageChanged: (index) {
      setState(() {
        index;
      });
    },
  );
}
