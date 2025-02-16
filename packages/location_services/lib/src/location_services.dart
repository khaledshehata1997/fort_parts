// ignore_for_file: unused_element

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationServices {
  static LatLng? currentLocation;
  static LatLng saudiArabiaLocation = const LatLng(23.611611925444677, 44.724358919514444);

  static void updateLocation({
    required LatLng location,
  }) {
    currentLocation = location;
  }

  static Future<LocationPermission> _checkLocationPermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();

    return permission;
  }

  static Future<LocationPermission> _requestLocationPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();

    return permission;
  }

  static Future<bool> _checkLocationService() async {
    final bool status = await Permission.location.serviceStatus.isEnabled;

    return status;
  }

  static Future<void> _requestLocationService() async {
    final bool status = await _checkLocationService();
    if (!status) {
      await AppSettings.openAppSettings(
        type: AppSettingsType.location,
      );
    }
  }

  static Future<Position> _fetchLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    return position;
  }

  static Future<void> fetchLocation() async {
    final LocationPermission permission = await _checkLocationPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      final Position position = await _fetchLocation();
      updateLocation(location: LatLng(position.latitude, position.longitude));
    } else {
      final LocationPermission permission = await _requestLocationPermission();
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        final Position position = await _fetchLocation();
        updateLocation(location: LatLng(position.latitude, position.longitude));
      }
    }
  }

  static Future<Placemark> fetchFormattedAddress({
    required BuildContext context,
    required double latitude,
    required double longitude,
  }) async {
    await setLocaleIdentifier("ar");

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    return placeMarks.first;
  }
}
