// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';

class MapScreen extends StatefulWidget {
  final String title;
  final String? longitude, latitude;
  final bool isSet;
  const MapScreen({
    Key? key,
    this.longitude,
    this.latitude,
    required this.isSet,
    required this.title,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  LatLng? lastLocation;
  String latitude = '', longitude = '';
  String selectedAddress = "";

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimary,
          iconTheme: const  IconThemeData(color: Colors.white),
          centerTitle: true,
          title: CustomText(
            text: widget.title,
            fontSize: AppStyle.small.sp,
            color: Colors.white,
          ),
        ),
        body: Stack(
          children: [
             GoogleMap(
                    initialCameraPosition: CameraPosition(target: lastLocation ?? const LatLng(25.2062701, 55.3498132), zoom: 10),
                    onMapCreated: onMapCreated,
                    onCameraMove: _onCameraMoved,
                    onTap: _handleTap,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: Set<Marker>.of(markers.values),
                  ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: CustomButton(
                      height: 45.h,
                      width: 270.w,
                      color: kPrimary,
                      circular: 5,
                      onPressed: () async{
                       if (lastLocation == null) return SnackBarBuilder.showFeedBackMessage(context, translate("toast.select_location"), Colors.red);
                       final data  = await Util.getAndSaveLocationDetails(lastLocation!);
                       Navigator.pop(context, LocationMapEntity(lat: lastLocation!.latitude,long: lastLocation!.longitude,city: data.locality.toString(),country: data.country.toString(),address: "${data.country}-${data.subLocality}-${data.street}-${data.administrativeArea}"));
                      },
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 7.w,
                              ),
                              CustomText(
                                text: selectedAddress,
                                fontSize: AppStyle.verySmall.sp - 2,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          CustomText(
                            text: translate("button.ok"),
                            fontSize: AppStyle.small.sp,
                            color: Colors.white,
                          ),
                        ],
                      )),
                ),
              ),
          ],
        ));
  }

  _setUp() {
    try {
      Util.checkLocationPermission();
      _setUserCurrentLocation();
      _setLocationOnMap();
    } catch (e) {
      debugPrint("_setUp: $e");
    }
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
      mapController = controller;
    });
  }

  void _onCameraMoved(CameraPosition position) {
    lastLocation = position.target;
  }

  _setLocationOnMap() async {
    try {
      if (widget.latitude == null) return;
      debugPrint("lat & lon location: ${widget.latitude}${widget.longitude}");
      var markerIdVal = widget.longitude!;
      final MarkerId markerId = MarkerId(markerIdVal);
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(double.parse(widget.latitude.toString()),
            double.parse(widget.longitude.toString())),
        infoWindow: const InfoWindow(
          title: '',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      setState(() {
        markers[markerId] = marker;
      });
    } catch (e) {
      debugPrint("_setLocationOnMap: $e");
    }
  }

  _handleTap(LatLng point) async {
    if (widget.isSet == false) return;
    markers.clear();
    try {
      Marker marker = Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: translate("cart.selected"),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      setState(() {
        lastLocation = point;
        markers[MarkerId(point.toString())] = marker;
      });
      LatLng latLng = LatLng(point.latitude, point.longitude);
      if (widget.title == translate("store.use_your_location")) {
        _checkIFUserLocation(await Util.getAndSaveLocationDetails(latLng), latLng);
      } else {
        final data  = await Util.getAndSaveLocationDetails(latLng);
        Navigator.pop(context, LocationMapEntity(lat: point.latitude,long: point.longitude,country: data.country.toString(),city: data.locality.toString(),address: "${data.country}-${data.subLocality}-${data.street}-${data.administrativeArea}"));
      }
    } catch (e) {
      debugPrint("_handleTap: $e");
    }
  }

  _setUserCurrentLocation() async {
    if (widget.longitude == null) {
      markers.clear();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if(mounted){
        setState(() {
          lastLocation = LatLng(position.latitude, position.longitude);
        });
      }
    } else {
      latitude = widget.latitude!;
      longitude = widget.longitude!;
      lastLocation = LatLng(double.parse(latitude.toString()),
          double.parse(longitude.toString()));
    }
    if(mounted){
      Timer(const Duration(milliseconds: 100), () async {
        mapController.animateCamera(CameraUpdate.newLatLngZoom(lastLocation!, 14));
        _checkIFUserLocation(await Util.getAndSaveLocationDetails(lastLocation!), lastLocation!);
      });
    }
  }

  _checkIFUserLocation(Placemark data, LatLng latLng) {
    try {
      if (widget.title == translate("store.use_your_location")) {
        SharedPref().setPreferenceDouble(Constants.userLatitude, latLng.latitude);
        SharedPref().setPreferenceDouble(Constants.userLongitude, latLng.longitude);
      }
      if(mounted) {
        setState(() {
          selectedAddress = "${data.country}-${data.subLocality}-${data.street}-${data.administrativeArea}";
        });
      }
      SharedPref().setPreferencesString(Constants.userLocationDetails, selectedAddress);
    } catch (e) {
      debugPrint("_checkIFUserLocation $e");
    }
  }
}

class LocationMapEntity{
  final double lat;
  final double long;
  final String city;
  final String country;
  final String address;
  LocationMapEntity({required this.lat,required this.long,required this.address,required this.city,required this.country});
}
