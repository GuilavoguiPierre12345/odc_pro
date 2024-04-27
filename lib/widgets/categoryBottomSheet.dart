import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/widgets/input.dart';

Widget categoryBottomSheet({required String typeAction}) {
  final formKey = GlobalKey<FormBuilderState>();

  return Container(
      height: 170,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: formKey,
          child: ListView(
            children: [
              inputWidget(
                  typeAction: typeAction,
                  defaultValue: "category default",
                  inputName: "category",
                  inputLabel: "Categori du lieu",
                  errorText: "Thi field is required",
                  prefixIcon: Icons.category),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GFButton(
                  size: GFSize.LARGE,
                  fullWidthButton: true,
                  type: GFButtonType.outline,
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      if (typeAction == "add") {
                        Get.back();
                      } else {
                        Get.back();
                      }
                      // Get.to(const IndexPage());
                    }
                  },
                  color: Colors.white,
                  child: Text(
                    typeAction == "add" ? "Ajouter" : "Mise a jour",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
}
