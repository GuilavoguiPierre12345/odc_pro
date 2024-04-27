import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

Widget InputFrom({required String titre,required String hin,required String nom,required String error}){
  return FormBuilderTextField(
    
     validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: error),
        ]),
    name: nom,decoration: InputDecoration(
      hintText: hin,
      floatingLabelStyle: TextStyle(fontSize: 30,color: Color(0xFF33BBC5)),
      hintStyle: TextStyle(color: Color(0xFF33BBC5)),
      label: Text(titre,style: TextStyle(fontSize: 24),),
      
      labelStyle: TextStyle(fontSize: 24,color: Color(0xFF33BBC5))
    ),);
}

