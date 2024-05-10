import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geodesy/geodesy.dart' as g;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as k;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// ignore: camel_case_types, must_be_immutable
class Detail_Categorie_detail extends StatefulWidget {
  Detail_Categorie_detail({super.key, this.dataAll});
  Map<dynamic,dynamic>? dataAll;


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
      icon: k.BitmapDescriptor.defaultMarker,
      
    ));
    setState(() {});
  }
  
  
  static final Marker destination = Marker(markerId: k.MarkerId("Destination"),
  infoWindow: k.InfoWindow(title: 'destination'),
  icon: k.BitmapDescriptor.defaultMarkerWithHue(k.BitmapDescriptor.hueYellow),
  position: k.LatLng(37.432962653311129, -127.08832357078792),
  );

  static final g.PolyLine polylines= g.PolyLine(
    
  );

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
          title: const Text("Detail direction"),
        ),
        body: SingleChildScrollView(
          child: Expanded(
            child:currentPosition!=null? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  child: k.GoogleMap(
                    initialCameraPosition: k.CameraPosition(target: k.LatLng(currentPosition!.latitude, currentPosition!.longitude),
                    zoom: 15,),
                    markers: {
                      
                      destination
                    },
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
                const SizedBox(height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 20,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Lieu:",style: TextStyle(fontSize: 30),),
                            Text("faad food",style: TextStyle(fontSize: 28,color: Colors.red),),
                          ],
                        ),
                        SizedBox(height: 20,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Categorie:",style: TextStyle(fontSize: 30),),
                            Text("restaurant",style: TextStyle(fontSize: 28,color: Colors.red),),
                          ],
                        ),
                         SizedBox(height: 20,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Contact:",style: TextStyle(fontSize: 30),),
                            Text("621670812",style: TextStyle(fontSize: 28,color: Colors.red),),
                          ],
                        ),
                         SizedBox(height: 20,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Distance:",style: TextStyle(fontSize: 30),),
                            Text("1.5 km",style: TextStyle(fontSize: 28,color: Colors.red),),
                          ],
                        ),
                    
                      ],
                    ),
                  ),
                ),
              ],
            ):const Center(
                  child: CircularProgressIndicator(),
                ),
          ),
        ),
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
    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition as k.CameraPosition));
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
