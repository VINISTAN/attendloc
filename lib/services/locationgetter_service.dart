import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationgetterService{
  Future<Position> getCurrentLocation () async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check the location service are enables
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(! serviceEnabled){
      return Future.error("Location services are disabled");
    }

    //Check for location permissions
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location Permissions are denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error('Location Permissions are Permanatly denied');
    }
     return await Geolocator.getCurrentPosition(
       desiredAccuracy: LocationAccuracy.high
     );
  }

  Future<String> getAddressFromLatLan (Position position) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(position.latitude,position.longitude);
      Placemark place = placemark[0];
      return '${place.street},${place.locality},${place.postalCode},${place.country}';
    } catch (e) {
      return 'failed to get address : $e';
    }
  }
}