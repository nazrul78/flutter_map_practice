import 'package:flutter_map_practice/src/helpers/k_log.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  final location = Location();
  LatLng? currentLatLng;
  final currentLoc = Rx<LatLng?>(null);

  Future<void> locationListener() async {
    try {
      PermissionStatus permissionGranted;
      permissionGranted = await location.hasPermission();

      if (permissionGranted == PermissionStatus.granted) {
        location.onLocationChanged.listen((LocationData currentLocation) {
          // Use current location
          // klog(
          //     'Current location : ${currentLocation.latitude}, ${currentLocation.longitude}');
          final latLng = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );

          //=============== To move current location when it changing ===========
          currentLoc.value = latLng;
          // if (Base.homePageController.isCurrentLocationEnable.value) {
          //   // Get.put(HomeMapViewController()).showCurrentLocationOnMap();
          //   currentLoc.value = latLng;
          // }
        });
      }
    } catch (e) {
      klog(e);
    }
  }

  /// To grant location permission
  Future<bool> enableLocationPermission() async {
    bool status = false;

    PermissionStatus permissionGranted;
    try {
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return status;
        }
      }
      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) {
        //isLocationPermissionEnable.value = true;
        status = true;
      } else {
        status = false;
      }
    } catch (e) {
      klog(e);
    }
    return status;
  }

  /// To grant location service permission
  Future<void> enableLocationService() async {
    if (await location.serviceEnabled()) {
      // isLocationServiceEnable.value = true;
    } else if (await location.requestService()) {
      // isLocationServiceEnable.value = true;
    } else {
      await enableLocationService();
    }
  }
}
