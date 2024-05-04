import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

Widget checkboxInput(
    {String? typeAction,
    String? defaultValue,
    required String inputName,
    String? errorText,
    required String labelTitle,
    IconData? prefixIcon}) {
  return FormBuilderCheckbox(
    name: inputName,
    title: Text(
      labelTitle,
      style: const TextStyle(
          color: Colors.white, fontSize: 19.5, fontWeight: FontWeight.w500),
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      prefixIconColor: Colors.white,
      labelStyle: const TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
    ),
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: errorText),
    ]),
  );
}
