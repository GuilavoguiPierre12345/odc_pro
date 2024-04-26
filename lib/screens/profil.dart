import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

Widget profilPage(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0),
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 6,
          decoration: const BoxDecoration(color: Color(0xFF33BBC5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Ajouter un admin",
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: Colors.white, width: 2.0)),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
