import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/widgets/input.dart';

Widget addAdminBottomSheet({required String typeAction}) {
  final formKey = GlobalKey<FormBuilderState>();

  return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(231, 51, 187, 197),
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
                  defaultValue: "Guilavogui",
                  inputName: "nomcomplet",
                  inputLabel: "Nom complet",
                  errorText: "Thi field is required",
                  prefixIcon: Icons.person),
              inputWidget(
                  typeAction: typeAction,
                  defaultValue: "Guilavogui",
                  inputName: "profession",
                  inputLabel: "Profession",
                  errorText: "This field is required",
                  prefixIcon: Icons.work),
              inputWidget(
                  typeAction: typeAction,
                  defaultValue: "Guilavogui",
                  inputName: "contact",
                  inputLabel: "Contact",
                  errorText: "This field is required",
                  prefixIcon: Icons.phone),
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
