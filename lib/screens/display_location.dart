import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/services/locationgetter_service.dart';

class DisplayLocation extends StatefulWidget {
  const DisplayLocation({Key? key}) : super(key: key);

  @override
  State<DisplayLocation> createState() => _DisplayLocationState();
}

class _DisplayLocationState extends State<DisplayLocation> {
  String currentAddress = 'Getting Location..';
  final LocationgetterService locationgetterService = LocationgetterService();

  @override
  void initState(){
    super.initState();
    getLocation();
  }

  Future<void> getLocation () async {
    try {
      Position position = await locationgetterService.getCurrentLocation();
      String address = await locationgetterService.getAddressFromLatLan(position);
      setState(() {
        currentAddress = address;
      });
    }catch (e){
      setState(() {
        currentAddress = 'Error $e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(currentAddress),),
    );
  }
}

