import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/widgets/checkboxInput.dart';
import 'package:odc_pro/widgets/input.dart';
import 'package:odc_pro/widgets/selectInput.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

Widget lieuBottomSheet(
    {required String typeAction,
    required BuildContext context,
    required Function setState,
    required QueryDocumentSnapshot<Map<String, dynamic>> lieu
    }) {
  final formKey = GlobalKey<FormBuilderState>();
  TimeOfDay? selectedTime = TimeOfDay.now();
  double plong = 0;
  double plat = 0;
  ProgressDialog pd = ProgressDialog(context: context);

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("verification 1");
      Future.error("Location service is not enabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    // permission refused temporarily
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("verification 2");
        return Future.error("Location permission are denied");
      }
    }
    // permission refused permanently
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }

    return await Geolocator.getCurrentPosition();
  }

  return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(231, 51, 187, 197),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                inputWidget(
                    typeAction: typeAction,
                    defaultValue: "Conakry",
                    inputName: "nomLieu",
                    inputLabel: "Nom du lieu",
                    errorText: "Thi field is required",
                    prefixIcon: Icons.house),
                inputWidget(
                    typeAction: typeAction,
                    defaultValue: "Macenta",
                    inputName: "ville",
                    inputLabel: "Ville",
                    errorText: "This field is required",
                    prefixIcon: Icons.location_city),
                inputWidget(
                    typeAction: typeAction,
                    defaultValue: "mamou",
                    inputName: "quartier",
                    inputLabel: "Nom du quartier",
                    errorText: "This field is required",
                    prefixIcon: Icons.houseboat),
                selectWidget(
                    typeAction: typeAction,
                    defaultValue: "6255-6395",
                    inputName: "category",
                    inputLabel: "Categorie",
                    errorText: "This field is required",
                    prefixIcon: Icons.category),
                inputWidget(
                    typeAction: typeAction,
                    defaultValue: "6255-6395",
                    inputName: "contact1",
                    inputLabel: "Contact 1",
                    errorText: "This field is required",
                    prefixIcon: Icons.work),
                inputWidget(
                    typeAction: typeAction,
                    defaultValue: "621627214",
                    inputName: "contact2",
                    inputLabel: "Contact 2",
                    errorText: "This field is required",
                    prefixIcon: Icons.phone),
                // datePickerInput(
                //     inputName: "heureouverture", inputLabel: "heure"),
                // checkboxInput(inputName: "date", labelTitle: "Lundi"),
                Table(
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: checkboxInput(
                            inputName: "date",
                            labelTitle: "Lundi",
                            prefixIcon: Icons.calendar_month),
                      ),
                      TableCell(
                          child: GFButton(
                        type: GFButtonType.outline,
                        onPressed: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: selectedTime ?? TimeOfDay.now(),
                          );
                          if (timeOfDay != null) {
                            setState(() {
                              selectedTime = timeOfDay;
                            });
                            print(selectedTime);
                          }
                        },
                        child: Text(
                            "${selectedTime.hour} : ${selectedTime.minute}"),
                      ))
                    ]),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Long : $plong - Lat : $plat",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      GFButton(
                          type: GFButtonType.outline,
                          onPressed: () {
                            pd.show(
                                max: 100, msg: "chargement de la position...");
                            _getCurrentLocation().then((posit) {
                              setState(() {
                                plong = posit.longitude;
                                plat = posit.latitude;
                              });
                              print("Long :${plong} - Lat :${plat}");
                              pd.close();
                            });
                          },
                          child: const Text(
                              "cliquer pour charger la position du lieu"))
                    ],
                  ),
                ),
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
        ),
      ));
}
