import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

Widget inputWidget(
    {
      String? typeAction,
      String? defaultValue,
      bool? obs=false,
      required String inputName,
      required String inputLabel,
      required String errorText,
      IconData? prefixIcon
    }
    ) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FormBuilderTextField(
      initialValue: typeAction != "add" ? defaultValue : "",
      name: inputName,
      obscureText: obs!,
      style: const TextStyle(color: Colors.white, fontSize: 24),
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
    ),
  );
}
