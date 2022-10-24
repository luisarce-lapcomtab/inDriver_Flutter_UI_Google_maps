import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver/themes/mapstyle.dart';
import 'package:indriver/widgets/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LatLng currentLocation = const LatLng(-2.1611081, -79.9022226);
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController locationController = TextEditingController();
  late LocationPermission permission;

  bool buscando = false;
  bool padding = true;
  String header = "";

  @override
  void initState() {
    getUserLocation();
    requestPerms();
    super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  Future<void> onCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    GoogleMapController mapcontroller = await _controller.future;
    mapcontroller.setMapStyle(jsonEncode(mapStyle));
    setState(() {});
  }

  requestPerms() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
      if (permission == LocationPermission.denied) {
        return;
      }
    }
  }

  void getMoveCamera() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    locationController.text = placemark[0].name.toString();
    setState(() {
      header = placemark[0].name.toString();
    });
  }

  Future<void> getUserLocation() async {
    final GoogleMapController controller = await _controller.future;

    List<Placemark> placemark = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentLocation = LatLng(position.latitude, position.longitude);
    locationController.text = placemark[0].name.toString();
    controller.animateCamera(CameraUpdate.newLatLng(currentLocation));
  }

  void onCameraMove(CameraPosition position) async {
    setState(() {});
    buscando = false;
    currentLocation = position.target;
  }

  void onCameraIdle() {
    buscando = true;
    padding = false;
    setState(() {});
    getMoveCamera();
  }

  @override
  Widget build(BuildContext context) {
    final double maxheight = MediaQuery.of(context).size.height - 5;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: maxheight,
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: currentLocation, zoom: 14.5),
                onMapCreated: onCreated,
                compassEnabled: true,
                zoomControlsEnabled: false,
                mapToolbarEnabled: true,
                padding: padding
                    ? const EdgeInsets.only(bottom: 314)
                    : const EdgeInsets.only(bottom: 315),
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onCameraMove: onCameraMove,
                onCameraIdle: onCameraIdle,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -160),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buscando == true
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue[600],
                          ),
                          width: 195,
                          height: 38,
                          child: Center(
                            child: Text(
                              header,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13.2),
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue[600]),
                          width: 48,
                          height: 38,
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 2.6,
                            ),
                          ),
                        ),
                  Image.asset(
                    "assets/markeruser.png",
                    height: 175,
                  ),
                ],
              ),
            ),
            const BtnMenu(),
            const BtnShare(),
            Positioned(
              bottom: 330,
              right: 8.0,
              child: FloatingActionButton(
                mini: true,
                onPressed: getUserLocation,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.gps_fixed,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            const BannerMsj(),
            Positioned(
                bottom: 0,
                left: 1,
                right: 1,
                child: Container(
                  height: 290,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(fontSize: 15),
                        enabled: false,
                        controller: locationController,
                        decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            icon: Icon(
                              Icons.fiber_manual_record,
                              size: 20,
                              color: Colors.green,
                            )),
                      ),
                      GestureDetector(
                        onTap: () => showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => const Destination()),
                        child: const Input(
                          hintText: " Destination",
                          icon: Icons.fiber_manual_record,
                        ),
                      ),
                      GestureDetector(
                        onTap: (() => showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => const InputFare())),
                        child: const Input(
                          hintText: " Offer your fare",
                          icon: Icons.attach_money,
                        ),
                      ),
                      const Input(
                        hintText: " Comment and wishes",
                        icon: Icons.insert_comment_outlined,
                      ),
                      const BtnRequest(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String hintText;
  final IconData icon;

  const Input({
    Key? key,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
            icon: Icon(icon, size: 20),
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
