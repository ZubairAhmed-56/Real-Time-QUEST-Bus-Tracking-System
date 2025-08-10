// ignore_for_file: unused_field, deprecated_member_use

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapdemo/utils/app_constant.dart';
import 'package:mapdemo/widgets/user_app_drawer.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  static const LatLng sourceLocation = LatLng(26.2327490, 68.3780339);
  final Completer<GoogleMapController> _mapController = Completer();
  late BitmapDescriptor busIcon;

  LatLng currentBusLocation = sourceLocation; // default location
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  List<LatLng> routePoints = [
    LatLng(26.2327490, 68.3780339), // sourceLocation
    LatLng(26.2372294, 68.3912677), // lakhahotalpoint
    LatLng(26.2395299, 68.3977096), // mehranhotelpoint
    LatLng(26.2405052, 68.4002157), // fuelstation
    LatLng(26.2427829, 68.4016199), // aleez
    LatLng(26.2481485, 68.4014290), // policechokipoint
    LatLng(26.2489790, 68.4065070), // policelineexitpoint
    LatLng(26.2472354, 68.4074793), // golchakrapoint
    LatLng(26.2472591, 68.4071982), // blackandbrownpoint
    LatLng(26.2472933, 68.4018599), // dco
    LatLng(26.2427829, 68.4016199), // destination
  ];

  @override
  void initState() {
    super.initState();
    loadBusIcon();
    listenToBusLocation();
    addPolyline();
  }

  Future<void> loadBusIcon() async {
    busIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/bus_icon.png', // make sure this asset exists and is declared in pubspec.yaml
    );
  }

  void addPolyline() {
    _polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        points: routePoints,
        color: Colors.black,
        width: 5,
      ),
    );
  }

  void listenToBusLocation() {
    FirebaseFirestore.instance
        .collection('busLocation')
        .doc('current')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        double lat = snapshot['latitude'];
        double lng = snapshot['longitude'];

        setState(() {
          currentBusLocation = LatLng(lat, lng);
          _markers.clear();

          _markers.add(
            Marker(
              markerId: MarkerId('bus'),
              position: currentBusLocation,
              icon: busIcon,
              infoWindow: InfoWindow(title: 'Bus Location'),
            ),
          );
        });

        _moveCamera();
      }
    });
  }

  Future<void> _moveCamera() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentBusLocation,
          zoom: 17.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.primaryColor),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Quest Bus Tracking',
          style: TextStyle(
            color: AppConstant.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: UserAppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/uni.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Container(
                  height: 517,
                  width: double.infinity,
                  color: AppConstant.primaryColor,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: sourceLocation,
                      zoom: 15.0,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    onMapCreated: (GoogleMapController controller) {
                      if (!_mapController.isCompleted) {
                        _mapController.complete(controller);
                      }
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
