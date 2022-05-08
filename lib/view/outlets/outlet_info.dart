import 'dart:convert';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../model/outlet.dart';
import '../../utils/utilities.dart';
import '../products/brandwiseproduct.dart';

class OutletInfoPages extends StatefulWidget{

  final Outlet outlet;
  OutletInfoPages({Key key, this.outlet}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OutletInfoPage();
  }

}
class OutletInfoPage extends State<OutletInfoPages>{


  String base64Image;
  XFile _imageFile;
  final ImagePicker _picker = ImagePicker();
    GoogleMapController mapController;

    LatLng _center = const LatLng(27.7172, 85.3240);
   Location _location  ;
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

  // OutletInfoPages({@required this.outlet});
  @override
  Widget build(BuildContext context) {

    void pickImage() async {
      try {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 25,
        );
        if (pickedFile != null) {
          setState(() {
            _imageFile = pickedFile;

          });
          List<int> imageBytes = await pickedFile.readAsBytes();
          base64Image = base64Encode(imageBytes);

          print(base64Image);
        }
      } catch (e) {
        Utilities.showInToast(e.message);
      }
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon( Icons.arrow_back,
          color: Color.fromARGB(255, 34, 47, 53),)
         ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.shield_moon,
                color: Color.fromARGB(255, 34, 47, 53)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.edit, color: Color.fromARGB(255, 34, 47, 53)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:
            Icon(Icons.more_vert, color: Color.fromARGB(255, 34, 47, 53)),
          ),
        ],
        title:   Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            widget.outlet.name,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  pickImage();
                },
                child: Container(
                  constraints: BoxConstraints.expand(
                    height:
                    Theme.of(context).textTheme.headline4.fontSize * 1.1 +
                        200.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child:_imageFile == null
                      ? Center(
                    child: const Icon(
                      Icons.cloud_download_sharp,
                      size: 100,
                      color: Colors.blue,
                    ),
                  )
                      : Image.file(File(_imageFile.path)),
                  // const Icon(
                  //   Icons.cloud_download_sharp,
                  //   size: 100,
                  //   color: Colors.blue,
                  // ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:   [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 35,
                      ),
                      // title: Text(
                      //   outlet.name,
                      //   style: TextStyle(
                      //     fontSize: 15.0,
                      //     color: Color.fromARGB(255, 22, 21, 21),
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      subtitle: Text("${widget.outlet.name}"),
                    ),
                    ListTile(
                      onTap: (){
                        Get.to(() =>
                        BrandWiseProduct(outlet: widget.outlet
                          // Get
                          //   .find<OutletsController>()
                          //   .outletList[index])
                        ) );
                      },
                      leading: Icon(
                        Icons.phone_android,
                        size: 35,
                      ),
                      title: Text(
                       widget.outlet.name,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color.fromARGB(255, 22, 21, 21),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text("Contact Person"),
                      trailing: Icon(Icons.shield_moon),
                    ),
                    // ListTile(
                    //   onTap: (){
                    //     BrandWiseProduct(outlet: widget.outlet
                    //             // Get
                    //             //   .find<OutletsController>()
                    //             //   .outletList[index])
                    //     );
                    //   },
                    //   title: Text(
                    //     'Call History',
                    //     style: TextStyle(
                    //       fontSize: 15.0,
                    //       color: Color.fromARGB(255, 22, 21, 21),
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: ListTile(
                    //     title: Text(
                    //       'Order History',
                    //       style: TextStyle(
                    //         fontSize: 15.0,
                    //         color: Color.fromARGB(255, 22, 21, 21),
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     trailing: Icon(Icons.arrow_forward_ios),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 300,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                  myLocationEnabled: true,
                  markers: getmarkers(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      // markers.add(Marker(
      //   //add first marker
      //   markerId: MarkerId(_center.toString()),
      //   position: _center, //position of marker
      //   infoWindow: InfoWindow(
      //     //popup info
      //     title: 'Marker Title First ',
      //     snippet: 'My Custom Subtitle',
      //   ),
      //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      // ));
      // markers.add(Marker(
      //   //add second marker
      //   markerId: MarkerId(_center.toString()),
      //   position: LatLng(27.7099116, 85.3132343), //position of marker
      //   infoWindow: InfoWindow(
      //     //popup info
      //     title: 'Marker Title Second ',
      //     snippet: 'My Custom Subtitle',
      //   ),
      //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      // ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(_center.toString()),
        position: LatLng(double.parse(widget.outlet.latitude), double.parse(widget.outlet.longitude)), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}
