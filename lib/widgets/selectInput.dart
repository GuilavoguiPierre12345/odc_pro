import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


Widget selectWidget(
    {String? typeAction,
    String? defaultValue,
    List<Map<String,dynamic>>? categories,
    required String inputName,
    required String inputLabel,
    required String errorText,
    IconData? prefixIcon}) {
  
  
  
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: FormBuilderDropdown(
        name: inputName,
        initialValue: typeAction != "add" ? defaultValue : "",
        autovalidateMode: AutovalidateMode.always,
        dropdownColor: const Color(0xFF33BBC5),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          prefixIconColor: Colors.white,
          labelText: inputLabel,
          labelStyle: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: errorText),
        ]),
        items: categories!
            .map((option) => DropdownMenuItem(
                alignment: AlignmentDirectional.centerStart,
                value: option["key"],
                child: Text(
                  "${option["value"]["categorie"]}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )))
            .toList()

        // const [

        //   DropdownMenuItem(
        //       alignment: AlignmentDirectional.centerStart,
        //       value: "categorie",
        //       child: Text(
        //         "categorie",
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 20,
        //             fontWeight: FontWeight.w500),
        //       )),
        // ],
        ),
  );
}
