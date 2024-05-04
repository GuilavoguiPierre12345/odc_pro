import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geodesy/geodesy.dart' as g;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as k;

// ignore: camel_case_types
class Detail_Categorie_detail extends StatefulWidget {
  const Detail_Categorie_detail({super.key});

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
  g.LatLng startPoint = const g.LatLng(37.7749, -12.4194); // Coordonnées de San Francisco
  g.LatLng endPoint = const g.LatLng(37.7749, -120.4194); 
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    
  }
  void calculateDistance() {
    g.Geodesy geodesy = g.Geodesy();
    distance = geodesy.distanceBetweenTwoGeoPoints(startPoint, endPoint) as double;
    setState(() {
      
    });
  }

void getCurrentLocation() async {
  LocationPermission isLocationPermissionGranted = (await Geolocator.requestPermission());
    if(isLocationPermissionGranted == LocationPermission.denied){
            Get.snackbar("Location", "Veuillez autorisé la localisaton");
    }else{
        var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
    });
    }
    
  }

  //recuperatin du label des city
    void addMarker(k.LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String cityName = placemarks[0].locality!;
    markers.add(
      k.Marker(
      markerId: k.MarkerId(position.toString()),
      position: position,
      infoWindow: k.InfoWindow(
        title: cityName,
        snippet: 'Lat: ${position.latitude}, Long: ${position.longitude}',
        
      ),
    ));
    setState(() {});
  }

  final Completer<k.GoogleMapController> _controller = Completer();
  

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail direction"),
        ),
        body: SingleChildScrollView(
          child: Expanded(
            child:currentPosition!=null? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height-250,
                  child: k.GoogleMap(
                    initialCameraPosition: k.CameraPosition(target: k.LatLng(currentPosition!.latitude, currentPosition!.longitude),
                    zoom: 15,),
                    markers: Set.from(markers),
                    onTap: (currentPosition) {
                      addMarker(currentPosition);
                    },
                    //  markers: {
                    //       Marker(
                    
                    //         markerId: const MarkerId('currentPosition'),
                    //         position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
                    //         infoWindow: InfoWindow(
                    //           // title: cityName,
                    //           snippet: 'Lat: ${currentPosition!.latitude}, Long: ${currentPosition!.longitude}',
                    //         ),
                    //       ),
                    //     },
                    mapType: k.MapType.normal,
                    onMapCreated: (k.GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
                const SizedBox(height: 10,
                ),
                Card(
                  elevation: 6,
                  shadowColor: const Color(0xFF33BBC5),
                  child: RichText(
                    textScaler: TextScaler.noScaling,
                  textAlign: TextAlign.left,
                  // overflow: TextOverflow.clip,
                  text: TextSpan(
                  children: [
                    
                    const TextSpan(text: 'Categorie :',style: TextStyle(fontSize: 28,color: Colors.black45)),
                    const TextSpan(text: 'Restaurant\n',style: TextStyle(color: Colors.red,fontSize: 25)),
                    const TextSpan(text: 'Distance :',style: TextStyle(fontSize: 28,color: Colors.black45)),
                    TextSpan(text: "${distance.toStringAsFixed(2)} km\n",style: const TextStyle(color: Colors.red,fontSize: 25)),
                    const TextSpan(text: 'Contact :',style: TextStyle(fontSize: 28,color: Colors.black45)),
                    const TextSpan(text: '621 67 08 12',style: TextStyle(color: Colors.red,fontSize: 25))
                  ]
                ),
                
                ),
                ),
                
                ElevatedButton(onPressed: (){
                  setState(() {
                    calculateDistance();
                  });
                      
                }, child:const Text("Dis")),
              ],
            ):const Center(
                  child: CircularProgressIndicator(),
                ),
          ),
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     // goToLake();
        //   },
        //   label: const Text("To the like!"),
        //   icon: const Icon(Icons.directions_boat_outlined),
        // ),
      ),
    );
  }

  // Future<void> goToLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  // }
}
