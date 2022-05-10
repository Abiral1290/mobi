import 'dart:async';
//import 'package:flutter_google_maps_clusters/helpers/map_marker.dart';
import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';

import '../../controller/location_controller.dart';
import '../../model/Mapmarker.dart';
import '../../model/latlang.dart';
import '../../model/outlet.dart';
import '../../utils/utilities.dart';

class GoogelMaps extends StatefulWidget{

 // final Outlet outlet;
 //  GoogleMaps({Key key ,this.outlet}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GoogleMaps();
  }
}

class _GoogleMaps extends State<GoogelMaps>{
  // static final LatLng _kMapCenter =
  // LatLng(27.7123049, 85.313446);
  // static final CameraPosition _kInitialPosition =
  // CameraPosition(target: _kMapCenter, zoom: 8.0, tilt: 0, bearing: 0);view

   Outlet outlet;

  // var _streetCntrl = new TextEditingController().obs;
  // Position position;
  // Completer<GoogleMapController> _controller = Completer();
  // Map<String, Marker> markers = <String, Marker>{};
  // var street = "".obs;
  //
  //
  //
  // determineStreet(double lat, double lng) async {
  //   try {
  //     List<Placemark> placemarks =
  //     await placemarkFromCoordinates(position.latitude, position.longitude);
  //     street.value = placemarks[0].street;
  //     _streetCntrl.value.text = street.value;
  //     print("Place: " + placemarks[0].street);
  //   } catch (e) {
  //     Utilities.showInToast(
  //         "No address information found for supplied coordinates! Please manually write street address",
  //         toastType: ToastType.INFO);
  //   }
  // }
  //
  // determinePosition() async {
  //   if (Get.find<LocationController>().userPosition == null) {
  //     position = await GeolocatorPlatform.instance.getCurrentPosition(
  //     );
  //   } else {
  //     position = Get.find<LocationController>().userPosition;
  //   }
  //   if (position != null) {
  //     determineStreet(position.latitude, position.longitude);
  //   }
  // }
  // Widget _mapView(){
  //   CameraPosition postionss = CameraPosition(target: LatLng(),zoom:);
  //   return Obx(
  //       () => GoogleMap(
  //         mapToolbarEnabled: false,
  //           zoomControlsEnabled: false,
  //           myLocationButtonEnabled: true,
  //           rotateGesturesEnabled: true,
  //           markers: Set<Marker>.of(elements),
  //           polylines: mapControlle,
  //           initialCameraPosition: postionss)
  //   );
  // }

   // final List<MapMarker> markers = [];
   // final List<LatLng> markerLocations = [
   //   LatLng(41.147125, -8.611249),
   //   LatLng(41.145599, -8.610691),
   //   ...
   // ];
   // for (LatLng markerLocation in _markerLocations) {
   // markers.add(
   // MapMarker(
   // id: markerLocations.indexOf(markerLocation).toString(),
   // position: markerLocation,
   // icon: markerImage,
   // ),
   // );
   // }
  GoogleMapController mapController;

   final List<MapMarker> marker  =[];
   //String base64ImBitmapDescriptor.defaultMarkert<Marker> googleMarkers;


  //  final Fluster<MapMarker> fluster = Fluster<MapMarker>(
  //   minZoom: 20,
  //   maxZoom: 0,
  //   radius: 150,
  //   extent: 2048,
  //   nodeSize: 64,
  //
  //   createCluster: (
  //   BaseCluster cluster,
  //       double lat,
  //       double lng,
  //   ) => MapMarker(id: cluster.id.toString(), position: LatLng(lat, lng)    )
  // );

  LatLng _center = const LatLng(27.7172, 85.3240);
  Location _location ;
  final Set<Marker> markers = new Set(); //markers for google map
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 20),
        ),
      );
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setMarkers();
   // _markers.length;
    //getmarkers();
    //getmarkers();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setMarkers();
  //  _markers;
   // getmarkers();
  }
 // Maps() {
 //   Get.find<OutletsController>().outletList.forEach((element) {marker.add(
 //       MapMarker(id: element.id.toString(), position: LatLng(double.parse(element.latitude), double.parse(element.longitude)), icon: as)
 //   );});
 //   final List<Marker> googleMarkers = fluster.clusters([-180, -85, 180, 85], 20).map((e) => e.toMarker()).toList();
 // }
   @override
  Widget build(BuildContext context) {
    // TODO: implement build


  //  googleMarkers =  fluster.clusters([-180, -85, 180, 85], 20).map((e) => e.toMarker()).toList();
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: Text("press"),
            onPressed: (){
              print(_markers.length);
              //print(markerss.length);
            },
          )
        ],
      ),

      body:  buildMapContainer(),
      //GoogleMap(initialCameraPosition: _kInitialPosition)
    );
  }
  Widget buildMapContainer() {
    return  Container(
      child:   Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(

          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            myLocationEnabled: true,
            markers: _markers.toSet() == null ? "as" :  _markers.toSet(),
          ),
          ),
        ),
      );
    //   Container(
    //   height: Get.size.height * 0.2,
    //   child: position == null
    //       ? Center(
    //     child: CircularProgressIndicator(),
    //   )
    //       : GoogleMap(
    //     initialCameraPosition: CameraPosition(
    //         target: LatLng(position.latitude, position.longitude),
    //         zoom: 16),
    //     onMapCreated: (GoogleMapController controller) {
    //       _controller.complete(controller);
    //     },
    //     markers: Set<Marker>.of(markers.values),
    //     mapType: MapType.normal,
    //     zoomGesturesEnabled: true,
    //     myLocationEnabled: true,
    //     myLocationButtonEnabled: true,
    //     gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
    //       new Factory<OneSequenceGestureRecognizer>(
    //             () => new EagerGestureRecognizer(),
    //       ),
    //     ].toSet(),
    //     onLongPress: (LatLng latlng) {
    //       print(latlng.latitude.toString() +
    //           "," +
    //           latlng.longitude.toString());
    //       setState(() {
    //         markers["outletMarker"] = Marker(
    //           markerId: MarkerId("outletMarker"),
    //           position: new LatLng(latlng.latitude, latlng.longitude),
    //         );
    //       });
    //
    //       position = Position(
    //           longitude: latlng.longitude,
    //           latitude: latlng.latitude,
    //           timestamp: DateTime.now(),
    //           accuracy: 0.0,
    //           altitude: 0.0,
    //           heading: 0.0,
    //           speed: 0.0,
    //           speedAccuracy: 0.0);
    //       determineStreet(position.latitude, position.longitude);
    //     },
    //   ),
    // );
  }
  // Set<Marker> markerss = Set();
  //
  // Marker resultMarker = Marker(markerId: MarkerId("_center.toString()"),
  //   position: LatLng(double.parse(Get.find<OutletsController>().outletList[].latitude),double.parse(Get.find<OutletsController>().outletList[].longitude))
  //     ma
  // );
   List<Marker> _markers ;

   void setMarkers()   {
     //var notes =  Get.find<OutletsController>().outletList ;
     List<Marker> markers = Get.find<OutletsController>().outletList.map((n) {
       LatLng point = LatLng(double.parse(n.latitude == null? "27.45" : n.latitude) , double.parse(n.longitude == null? "89.45" :n.longitude)

       );
       var title = n.name;
       return Marker(
         position: point,
         markerId: MarkerId(_center.toString()),
         infoWindow: InfoWindow(
           title: title
         ),
         icon: BitmapDescriptor.defaultMarker,
         //point: point,
       );
     }).toList();
     // marker.removeWhere((element) {
     //   element.latitude == null;
     //    element.longitude == null;
     // });
    // marker.removeWhere((element) => element.longitude == null);
     setState(() {
      // _markers.clear();
       _markers = markers;
       _markers.removeWhere((element) => element.position == null);
     });

   }
 //  List<Marker> markerss =[];
 //   loadLocations() async {
 //     List<Outlet> locations = Get.find<OutletsController>().outletList;
 //     // locations = await getLocations; //we store the response in a list
 //     for (int i = 0; i < locations.length; i++) {
 //       LatLng latlng = new LatLng(
 //           double.parse(locations[i].latitude), double.parse(locations[i].longitude));
 //       this.markerss.add(Marker(
 //         markerId: MarkerId(locations[i].id.toString()),
 //         position: latlng,
 //       ));
 //     }
 //     setState(() {
 //       markerss;
 //     });
 //   }
 //   Set<Marker> getmarkers() {
 //    List<Outlet> out = Get.find<OutletsController>().outletList;
 //    //markers to place on mapfor
 //    for(var i = 0 ; i < 60; i++){
 //      setState(() {
 //        markers.add(Marker(
 //          //add third marker
 //            markerId: MarkerId(_center.toString()),
 //            position: LatLng(double.parse(Get.find<OutletsController>().outletList.last.latitude), double.parse(Get.find<OutletsController>().outletList.last.longitude)), //position of marker
 //            infoWindow: InfoWindow(
 //              //popup info
 //              title: Get.find<OutletsController>().outletList.last.name,
 //              // snippet: 'My Custom Subtitle',
 //            ),
 //            icon: BitmapDescriptor.defaultMarker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList.first.latitude), double.parse(Get.find<OutletsController>().outletList.first.longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[2].latitude), double.parse(Get.find<OutletsController>().outletList[2].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[3].latitude), double.parse(Get.find<OutletsController>().outletList[3].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[4].latitude), double.parse(Get.find<OutletsController>().outletList[4].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[5].latitude), double.parse(Get.find<OutletsController>().outletList[5].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[6].latitude), double.parse(Get.find<OutletsController>().outletList[6].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[7].latitude), double.parse(Get.find<OutletsController>().outletList[7].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[8].latitude), double.parse(Get.find<OutletsController>().outletList[8].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[10].latitude), double.parse(Get.find<OutletsController>().outletList[10].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[11].latitude), double.parse(Get.find<OutletsController>().outletList[11].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[12].latitude), double.parse(Get.find<OutletsController>().outletList[12].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[13].latitude), double.parse(Get.find<OutletsController>().outletList[13].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //            title: Get.find<OutletsController>().outletList.first.name,
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[14].latitude), double.parse(Get.find<OutletsController>().outletList[14].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //              title: (Get.find<OutletsController>().outletList[14].name)
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[15].latitude), double.parse(Get.find<OutletsController>().outletList[15].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //              title: (Get.find<OutletsController>().outletList[15].name)
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[16].latitude), double.parse(Get.find<OutletsController>().outletList[16].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //              title: (Get.find<OutletsController>().outletList[16].name)
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[17].latitude), double.parse(Get.find<OutletsController>().outletList[17].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //              title: (Get.find<OutletsController>().outletList[17].name)
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[18].latitude), double.parse(Get.find<OutletsController>().outletList[18].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //              title: (Get.find<OutletsController>().outletList[17].name)
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        markers.add(Marker(
 //          //add third marker
 //          markerId: MarkerId(_center.toString()),
 //          position: LatLng(double.parse(Get.find<OutletsController>().outletList[19].latitude), double.parse(Get.find<OutletsController>().outletList[19].longitude)), //position of marker
 //          infoWindow: InfoWindow(
 //            //popup info
 //              title: (Get.find<OutletsController>().outletList[19].name)
 //            // snippet: 'My Custom Subtitle',
 //          ),
 //          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //        ));
 //        //add more markers here
 //      });
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[20].latitude), double.parse(Get.find<OutletsController>().outletList[20].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[20].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[21].latitude), double.parse(Get.find<OutletsController>().outletList[21].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[21].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      )); markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[22].latitude), double.parse(Get.find<OutletsController>().outletList[22].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[22].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[23].latitude), double.parse(Get.find<OutletsController>().outletList[23].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[23].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[24].latitude), double.parse(Get.find<OutletsController>().outletList[24].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[24].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[25].latitude), double.parse(Get.find<OutletsController>().outletList[25].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[25].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[26].latitude), double.parse(Get.find<OutletsController>().outletList[26].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[26].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[27].latitude), double.parse(Get.find<OutletsController>().outletList[27].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[27].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[28].latitude), double.parse(Get.find<OutletsController>().outletList[28].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[28].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[29].latitude), double.parse(Get.find<OutletsController>().outletList[29].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[29].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[29].latitude), double.parse(Get.find<OutletsController>().outletList[29].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[29].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[30].latitude), double.parse(Get.find<OutletsController>().outletList[30].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[30].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[31].latitude), double.parse(Get.find<OutletsController>().outletList[31].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[31].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[32].latitude), double.parse(Get.find<OutletsController>().outletList[32].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[32].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[33].latitude), double.parse(Get.find<OutletsController>().outletList[32].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[32].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[34].latitude), double.parse(Get.find<OutletsController>().outletList[34].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[34].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[35].latitude), double.parse(Get.find<OutletsController>().outletList[35].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[35].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[36].latitude), double.parse(Get.find<OutletsController>().outletList[36].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[36].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[37].latitude), double.parse(Get.find<OutletsController>().outletList[37].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[37].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[38].latitude), double.parse(Get.find<OutletsController>().outletList[38].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[38].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[39].latitude), double.parse(Get.find<OutletsController>().outletList[39].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[39].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[40].latitude), double.parse(Get.find<OutletsController>().outletList[40].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[40].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[41].latitude), double.parse(Get.find<OutletsController>().outletList[41].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[41].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[42].latitude), double.parse(Get.find<OutletsController>().outletList[42].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[42].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      )); markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[43].latitude), double.parse(Get.find<OutletsController>().outletList[43].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[43].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[44].latitude), double.parse(Get.find<OutletsController>().outletList[44].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[44].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      )); markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[45].latitude), double.parse(Get.find<OutletsController>().outletList[45].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[45].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      )); markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[46].latitude), double.parse(Get.find<OutletsController>().outletList[46].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[46].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      )); markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[47].latitude), double.parse(Get.find<OutletsController>().outletList[47].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[47].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      )); markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[48].latitude), double.parse(Get.find<OutletsController>().outletList[48].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[48].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[49].latitude), double.parse(Get.find<OutletsController>().outletList[49].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[49].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      markers.add(Marker(
 //        //add third marker
 //        markerId: MarkerId(_center.toString()),
 //        position: LatLng(double.parse(Get.find<OutletsController>().outletList[50].latitude), double.parse(Get.find<OutletsController>().outletList[50].longitude)), //position of marker
 //        infoWindow: InfoWindow(
 //          //popup info
 //            title: (Get.find<OutletsController>().outletList[50].name)
 //          // snippet: 'My Custom Subtitle',
 //        ),
 //        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
 //      ));
 //      return markers;
 //    }
 //    }
}



