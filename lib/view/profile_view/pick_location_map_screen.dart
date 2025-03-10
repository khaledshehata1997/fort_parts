import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/view/profile_view/address_information_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_services/location_services.dart';

class PickLocationMapScreen extends StatefulWidget {
  const PickLocationMapScreen({
    super.key,
    this.address,
  });

  final Address? address;
  @override
  State<PickLocationMapScreen> createState() => _PickLocationMapScreenState();
}

class _PickLocationMapScreenState extends State<PickLocationMapScreen> {
  LatLng? selectedLocation;
  Set<Marker> markers = {};

  void setInitialLocation({
    required GoogleMapController controller,
  }) {
    if (widget.address != null) {
      selectedLocation = LatLng(double.parse(widget.address!.latitude), double.parse(widget.address!.longitude));
      final LatLng latLng = LatLng(double.parse(widget.address!.latitude), double.parse(widget.address!.longitude));
      markers.add(
        Marker(
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          infoWindow: InfoWindow(
            title: "",
            snippet: "${latLng.latitude}, ${latLng.longitude}",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {});
      controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title:  Text(
          'addresses'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          AppText(
            text: "yourLocation".tr,
            color: Color(0xFF333333),
            textStyles: AppTextStyles.medium18,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  markers: markers,
                  initialCameraPosition: CameraPosition(
                    target: LocationServices.currentLocation ?? LocationServices.saudiArabiaLocation,
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    setInitialLocation(controller: controller);
                  },
                  onTap: (LatLng latLng) async {
                    // Add a new marker at the tapped location
                    markers.clear();
                    markers.add(
                      Marker(
                        markerId: MarkerId(latLng.toString()),
                        position: latLng,
                        infoWindow: InfoWindow(
                          title: "",
                          snippet: "${latLng.latitude}, ${latLng.longitude}",
                        ),
                        icon: BitmapDescriptor.defaultMarker,
                      ),
                    );

                    setState(() {
                      selectedLocation = latLng;
                    });
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () async {
                      if (selectedLocation != null) {
                        print(selectedLocation!.latitude);
                        print(selectedLocation!.longitude);
                        final Placemark placeMark = await LocationServices.fetchFormattedAddress(
                            context: context, latitude: selectedLocation!.latitude, longitude: selectedLocation!.longitude);
                        AppNavigator.navigateTo(
                            type: NavigationType.navigateTo,
                            widget: AddressInformationScreen(
                              pickedLocation: selectedLocation!,
                              formattedAddress: placeMark.subLocality ?? "",
                              address: widget.address,
                            ));
                      }
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 30.h),
                      width: 343.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.fE0AA06,
                      ),
                      child: Center(
                        child: AppText(
                          text: "next".tr,
                          color: AppColors.fffffff,
                          textStyles: AppTextStyles.medium18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
