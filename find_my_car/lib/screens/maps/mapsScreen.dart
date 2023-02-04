import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
 class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> myMarkers = [];


  void getCurentLocation()async{
    Location location =  Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
    FirebaseFirestore.instance.collection('user').doc('n49tEXsPXmDmNMyJeWT2').set({
      'name': 'My phone',
      'location':GeoPoint(currentLocation.latitude!, currentLocation.longitude!),

    });

    });
  }
  @override
  void initState() {

    super.initState();
    getCurentLocation();
    FirebaseFirestore.instance.collection('user').snapshots().listen((event) {
      event.docChanges.forEach((change) {
       setState(() {
         myMarkers.add(
           Marker(
             markerId:  MarkerId(change.doc.id),
             position: LatLng(change.doc.data()!['location'].latitude, change.doc.data()!['location'].longitude),
             infoWindow:  InfoWindow(
               title: change.doc.data()!['name'].toString(),


             ),

           ),
         );
       });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.blueGrey,
        title: const Text('Your Car',
        style: TextStyle(
          color: Colors.white,
          fontSize: 27,
        ),
        ),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
         myLocationEnabled: true,
         zoomControlsEnabled: false,
         mapType: MapType.normal,
        initialCameraPosition:
        CameraPosition(
          target: LatLng(30.04167 ,31.23528),
          zoom: 5,
        ),
        onMapCreated:(GoogleMapController googleMapController){
          _controller.complete(googleMapController);
        },
        markers:myMarkers.toSet(),


      ),
    );
  }
}
