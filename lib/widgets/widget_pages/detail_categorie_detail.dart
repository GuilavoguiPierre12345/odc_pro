import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geodesy/geodesy.dart' as g;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as k;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:odc_pro/widgets/customCircularProgress.dart';

// ignore: camel_case_types, must_be_immutable
class Detail_Categorie_detail extends StatefulWidget {
  Detail_Categorie_detail(
      {super.key, required this.lieu, required this.categorie});
  QueryDocumentSnapshot<Map<String, dynamic>> lieu;
  String categorie;

  @override
  State<Detail_Categorie_detail> createState() =>
      _Detail_Categorie_detailState();
}

// ignore: camel_case_types
class _Detail_Categorie_detailState extends State<Detail_Categorie_detail> {
  Position? currentPosition;
  k.LatLng? currentLocation;
  List<k.Marker> markers = [];
  double distance = 0.0;
  g.LatLng startPoint =
      const g.LatLng(37.7749, -12.4194); // Coordonnées de San Francisco
  g.LatLng endPoint = const g.LatLng(37.7749, -120.4194);
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void calculateDistance() {
    g.Geodesy geodesy = g.Geodesy();
    distance =
        geodesy.distanceBetweenTwoGeoPoints(startPoint, endPoint) as double;
    setState(() {});
  }

  void getCurrentLocation() async {
    LocationPermission isLocationPermissionGranted =
        (await Geolocator.requestPermission());
    if (isLocationPermissionGranted == LocationPermission.denied) {
      Get.snackbar("Location", "Veuillez autorisé la localisaton");
    } else {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
      });
    }
  }

  //recuperatin du label des city
  void addMarker(k.LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String cityName = placemarks[0].locality!;
    markers.add(k.Marker(
      markerId: k.MarkerId(position.toString()),
      position: position,
      infoWindow: k.InfoWindow(
        title: cityName,
        snippet: 'Lat: ${position.latitude}, Long: ${position.longitude}',
      ),
      icon: k.BitmapDescriptor.defaultMarker,
    ));
    setState(() {});
  }

  static final Marker destination = Marker(
    markerId: k.MarkerId("Destination"),
    infoWindow: k.InfoWindow(title: 'destination'),
    icon: k.BitmapDescriptor.defaultMarkerWithHue(k.BitmapDescriptor.hueYellow),
    position: k.LatLng(37.432962653311129, -127.08832357078792),
  );

  static final g.PolyLine polylines = g.PolyLine();

  // static final Marker currentP = Marker(markerId: k.MarkerId("Destination"),
  // infoWindow: k.InfoWindow(title: 'destination'),
  // icon: k.BitmapDescriptor.defaultMarkerWithHue(k.BitmapDescriptor.hueBlue),
  // position: currentLocation!);

  final Completer<k.GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "DETAILS",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: currentPosition != null
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: k.GoogleMap(
                      initialCameraPosition: k.CameraPosition(
                        target: k.LatLng(currentPosition!.latitude,
                            currentPosition!.longitude),
                        zoom: 15,
                      ),
                      markers: {destination},
                      onTap: (currentPosition) {
                        addMarker(currentPosition);
                      },
                      mapType: k.MapType.normal,
                      onMapCreated: (k.GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Card(
                        elevation: 20,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Lieu:",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    widget.lieu["nomLieu"],
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFF33BBC5)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Ville:",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    widget.lieu["ville"],
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFF33BBC5)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Categorie:",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    widget.categorie,
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFF33BBC5)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Contact 1 :",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    widget.lieu["contact1"],
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFF33BBC5)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Contact 2 :",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    widget.lieu["contact2"],
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFF33BBC5)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Distance:",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "1.5 km",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                ],
                              ),
                              Text(
                                "EMPLOI DU TEMPS",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF33BBC5)),
                              ),
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
                                          child: Text("LUNDI",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["lhd"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["lhf"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Center(
                                          child: Text("MAR",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["mahd"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["mahf"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Center(
                                          child: Text("MERC",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["merhd"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["merhf"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Center(
                                          child: Text("JEU",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["jhd"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["jhf"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Center(
                                          child: Text("VEND",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["vhd"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["vhf"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Center(
                                          child: Text("SAME",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["shd"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["shf"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Center(
                                          child: Text("DIM",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["dhd"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    TableCell(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                            child: Text(
                                              widget.lieu["dhf"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ]),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : customCircularProgress(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            goToLake();
          },
          label: const Text("rotad"),
          icon: const Icon(Icons.directions_boat_outlined),
        ),
      ),
    );
  }

  Future<void> goToLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(currentPosition as k.CameraPosition));
  }
}



// Card(
//                   elevation: 6,
//                   shadowColor: const Color(0xFF33BBC5),
//                   child: RichText(
//                     textScaler: TextScaler.noScaling,
//                   textAlign: TextAlign.left,
//                   // overflow: TextOverflow.clip,
//                   text: TextSpan(
//                   children: [
                    
//                     const TextSpan(text: 'Categorie :',style: TextStyle(fontSize: 28,color: Colors.black45)),
//                     const TextSpan(text: 'Restaurant\n',style: TextStyle(color: Colors.red,fontSize: 25)),
//                     const TextSpan(text: 'Distance :',style: TextStyle(fontSize: 28,color: Colors.black45)),
//                     TextSpan(text: "${distance.toStringAsFixed(2)} km\n",style: const TextStyle(color: Colors.red,fontSize: 25)),
//                     const TextSpan(text: 'Contact :',style: TextStyle(fontSize: 28,color: Colors.black45)),
//                     const TextSpan(text: '621 67 08 12',style: TextStyle(color: Colors.red,fontSize: 25))
//                   ]
//                 ),
                
//                 ),
//                 ),
