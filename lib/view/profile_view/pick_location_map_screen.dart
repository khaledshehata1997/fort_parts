import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_services/location_services.dart';

class PickLocationMapScreen extends StatefulWidget {
  const PickLocationMapScreen({super.key});

  @override
  State<PickLocationMapScreen> createState() => _PickLocationMapScreenState();
}

class _PickLocationMapScreenState extends State<PickLocationMapScreen> {
  LatLng? selectedLocation;
  Set<Marker> markers = {};
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
        title: const Text(
          'العناوين',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            AppText(
              text: "حدد موقعك على الخريطة، ثم أكمل البيانات",
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
                    onMapCreated: (GoogleMapController controller) {},
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
                      onTap: () {
                        if (selectedLocation != null) {
                          // AppNavigator.navigateTo(type: NavigationType.navigateTo, widget: const PickLocationMapScreen());
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
                            text: "التالي",
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
      ),
    );
  }
}
