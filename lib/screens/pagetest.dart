import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/services/categorie_service.dart';
import 'package:odc_pro/services/lieu_service.dart';
import 'package:odc_pro/widgets/checkboxInput.dart';
import 'package:odc_pro/widgets/input.dart';
import 'package:odc_pro/widgets/selectInput.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class PageTest extends StatefulWidget {
  String typeAction;
  QueryDocumentSnapshot<Map<String, dynamic>>? lieu;

  PageTest({super.key, required this.typeAction, this.lieu});

  @override
  State<PageTest> createState() => _PageTestState();
}

class _PageTestState extends State<PageTest>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getAllCategories();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isAddBtnVisible = false;
  changeAddBtnVisibleState(String ta) {
    if (ta == "add") {
      setState(() {
        isAddBtnVisible = true;
      });
    }
  }

  CategorieService cs = CategorieService();
  List<Map<String, dynamic>> categories = [];
  Future<void> getAllCategories() async {
    await cs.dropdownList().then((value) {
      setState(() {
        categories = value;
      });
    });
  }

  final formKey = GlobalKey<FormBuilderState>();

  TimeOfDay? selectedTime = TimeOfDay.now();
  double plong = 0;
  double plat = 0;
  Map<String, dynamic> positionInfo = {};
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

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);

    return Scaffold(
        body: Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 4.5,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: .5,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/map.png"))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  widget.typeAction == "add"
                      ? "AJOUTER UN LIEU"
                      : "MODIFICATION DE LIEU",
                  style: const TextStyle(
                      fontSize: 30,
                      color: Color(0xFF33BBC5),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.location_on,
                size: 100,
                color: Color(0xFF33BBC5),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      opacity: .2,
                      image: AssetImage("assets/images/map.png")),
                  color: Color.fromARGB(231, 51, 187, 197),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        inputWidget(
                            typeAction: widget.typeAction,
                            defaultValue: widget.typeAction == "maj"
                                ? widget.lieu!["nomLieu"]
                                : "",
                            inputName: "nomLieu",
                            inputLabel: "Nom du lieu",
                            errorText: "Thi field is required",
                            prefixIcon: Icons.house),
                        inputWidget(
                            typeAction: widget.typeAction,
                            defaultValue: widget.typeAction == "maj"
                                ? widget.lieu!["ville"]
                                : "",
                            inputName: "ville",
                            inputLabel: "Ville",
                            errorText: "This field is required",
                            prefixIcon: Icons.location_city),
                        inputWidget(
                            typeAction: widget.typeAction,
                            defaultValue: widget.typeAction == "maj"
                                ? widget.lieu!["quartier"]
                                : "",
                            inputName: "quartier",
                            inputLabel: "Nom du quartier",
                            errorText: "This field is required",
                            prefixIcon: Icons.houseboat),
                        selectWidget(
                            categories: categories,
                            typeAction: widget.typeAction,
                            defaultValue: widget.typeAction == "maj"
                                ? widget.lieu!["category"]
                                : "",
                            inputName: "category",
                            inputLabel: "Categorie",
                            errorText: "This field is required",
                            prefixIcon: Icons.category),
                        inputWidget(
                            typeAction: widget.typeAction,
                            defaultValue: widget.typeAction == "maj"
                                ? widget.lieu!["contact1"]
                                : "",
                            inputName: "contact1",
                            inputLabel: "Contact 1",
                            errorText: "This field is required",
                            keyboardType: "phone",
                            prefixIcon: Icons.phone),
                        inputWidget(
                            typeAction: widget.typeAction,
                            defaultValue: widget.typeAction == "maj"
                                ? widget.lieu!["contact2"]
                                : "",
                            inputName: "contact2",
                            inputLabel: "Contact 2",
                            errorText: "This field is required",
                            keyboardType: "phone",
                            prefixIcon: Icons.phone),
                        // datePickerInput(
                        //     inputName: "heureouverture", inputLabel: "heure"),
                        // checkboxInput(inputName: "date", labelTitle: "Lundi"),
                        Table(
                          children: [
                            const TableRow(children: [
                              TableCell(
                                child: Center(child: Text("JOURS")),
                              ),
                              TableCell(
                                child: Center(child: Text("HO")),
                              ),
                              TableCell(
                                child: Center(child: Text("HF")),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: "lundi",
                                    readOnly: true,
                                    initialValue: widget.typeAction == "add"
                                        ? "Lundi"
                                        : widget.lieu!["lundi"],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: FormBuilderTextField(
                                    name: "lhd",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["lhd"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: FormBuilderTextField(
                                    name: "lhf",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["lhf"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: "mardi",
                                    readOnly: true,
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["lundi"]
                                        : "Mardi",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: FormBuilderTextField(
                                    name: "mahd",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["mahd"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: FormBuilderTextField(
                                    name: "mahf",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["mahf"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: "mercredi",
                                    readOnly: true,
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["mercredi"]
                                        : "Mercredi",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: FormBuilderTextField(
                                    name: "merhd",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["merhd"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: FormBuilderTextField(
                                    name: "merhf",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["merhf"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: "jeudi",
                                    readOnly: true,
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["jeudi"]
                                        : "Jeudi",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: FormBuilderTextField(
                                    name: "jhd",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["jhd"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: FormBuilderTextField(
                                    name: "jhf",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["jhf"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: "vendredi",
                                    readOnly: true,
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["vendredi"]
                                        : "Vendredi",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: FormBuilderTextField(
                                    name: "vhd",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["vhd"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: FormBuilderTextField(
                                    name: "vhf",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["vhf"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: "samedi",
                                    readOnly: true,
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["samedi"]
                                        : "Samedi",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: FormBuilderTextField(
                                    name: "shd",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["shd"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: FormBuilderTextField(
                                    name: "shf",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["shf"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: "dimanche",
                                    readOnly: true,
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["dimanche"]
                                        : "Dimanche",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: FormBuilderTextField(
                                    name: "dhd",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["dhd"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: FormBuilderTextField(
                                    name: "dhf",
                                    initialValue: widget.typeAction != "add"
                                        ? widget.lieu!["dhf"]
                                        : "0",
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Long : $plong - Lat : $plat",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              GFButton(
                                  type: GFButtonType.outline,
                                  onPressed: () {
                                    pd.show(
                                        max: 100,
                                        msg: "chargement de la position...");
                                    _getCurrentLocation().then((posit) {
                                      setState(() {
                                        plong = posit.longitude;
                                        plat = posit.latitude;
                                        positionInfo["longitude"] =
                                            posit.longitude;
                                        positionInfo["latitude"] =
                                            posit.latitude;
                                      });
                                      print("Long :${plong} - Lat :${plat}");
                                      changeAddBtnVisibleState(
                                          widget.typeAction);

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
                            child: (widget.typeAction == "add") &&
                                    isAddBtnVisible
                                ? GFButton(
                                    size: GFSize.LARGE,
                                    fullWidthButton: true,
                                    type: GFButtonType.outline,
                                    onPressed: () {
                                      if (formKey.currentState!
                                          .saveAndValidate()) {
                                        pd.show(
                                            max: 100,
                                            msg: "please wait...",
                                            progressBgColor:
                                                const Color(0xFF33BBC5));
                                        LieuService()
                                            .addLieu(
                                                formKey.currentState!.value,
                                                positionInfo)
                                            .then((value) {
                                          pd.close();
                                          Get.snackbar("ajouter d'un lieu",
                                              "Lieu ajouter avec success",
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        });
                                        Get.back();
                                        setState(() {});
                                      }
                                    },
                                    color: Colors.white,
                                    child: const Text("Ajouter",
                                        style: const TextStyle(fontSize: 20)),
                                  )
                                : GFButton(
                                    size: GFSize.LARGE,
                                    fullWidthButton: true,
                                    type: GFButtonType.outline,
                                    onPressed: () {
                                      if (formKey.currentState!
                                          .saveAndValidate()) {
                                        pd.show(
                                            max: 100,
                                            msg: "please wait...",
                                            progressBgColor:
                                                const Color(0xFF33BBC5));
                                        LieuService()
                                            .updateLieu(
                                                widget.lieu!.id,
                                                formKey.currentState!.value,
                                                positionInfo)
                                            .then((value) {
                                          pd.close();
                                          Get.snackbar("modification d'un lieu",
                                              "Lieu modifier avec success",
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        });
                                        Get.back();
                                        setState(() {});
                                      }
                                    },
                                    color: Colors.white,
                                    child: const Text("valider",
                                        style: TextStyle(fontSize: 20)),
                                  ))
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ],
    ));
  }
}
