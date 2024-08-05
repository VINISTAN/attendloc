// import 'package:flutter/material.dart';
// import 'package:one_clock/one_clock.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:myapp/services/locationgetter_service.dart';
//
//
// class LocationDetector extends StatefulWidget {
//   const LocationDetector({super.key});
//
//   @override
//   State<LocationDetector> createState() => _LocationDetectorState();
// }
//
// class _LocationDetectorState extends State<LocationDetector> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: LocationGetter());
//   }
// }
//
// class LocationGetter extends StatefulWidget {
//    LocationGetter({super.key});
//
//   @override
//   State<LocationGetter> createState() => _LocationGetterState();
// }
//
// class _LocationGetterState extends State<LocationGetter> {
//   DateTime dateTime = DateTime.now();
//   String currentAddress = 'Getting Location..';
//   final LocationgetterService locationgetterService = LocationgetterService();
//
//   void initState(){
//     super.initState();
//     _SetNewDateTime(dateTime);
//     getLocation();
//     print('Initstate current Address : $currentAddress');
//   }
//   Future<void> getLocation () async {
//     try {
//       Position position = await locationgetterService.getCurrentLocation();
//       String address = await locationgetterService.getAddressFromLatLan(position);
//       setState(() {
//         currentAddress = address;
//       });
//     }catch (e){
//       setState(() {
//         currentAddress = 'Error $e';
//       });
//     }
//   }
//
//   void _SetNewDateTime(DateTime currentTime){
//     setState((){
//       dateTime = currentTime;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double myheight = MediaQuery.of(context).size.height;
//     double mywidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: myheight / 2.5,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.fill, image: AssetImage('assets/punchin.png'))),
//             ),
//             SizedBox(
//               height: myheight / 50,
//             ),
//             AnalogClock(isLive: true,
//             height: myheight/2.5,
//             datetime: dateTime,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle
//             ),),
//             SizedBox(
//               height: myheight / 25,
//             ),
//             Container(
//                 width: mywidth / 1.2,
//                 decoration: const BoxDecoration(
//                     color: Colors.orange,
//                     borderRadius: BorderRadius.all(Radius.circular(25))),
//                 child: TextButton(
//                   onPressed: () {
//                     getLocation ();
//                     print("Calling function : $currentAddress");
//                     _confirmLocationDialog();
//
//                     //Navigator.push(context, MaterialPageRoute(builder: (context)=> DisplayLocation()));
//                   },
//                   child: const Text(
//                     "Punch - In",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 )),
//             SizedBox(
//               height: myheight / 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//    Future _confirmLocationDialog() async {
//     return
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           double myheight = MediaQuery.of(context).size.height;
//           double mywidth = MediaQuery.of(context).size.width;
//           return AlertDialog(
//             title: Text("We found your Location"),
//             content: Text(currentAddress),
//             actions: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(onPressed: (){}, child: Text("Confirm")),
//                   TextButton(onPressed: (){}, child: Text("Edit"))
//                 ],
//               )
//             ],
//           );
//         },
//       );
//
//    }
// }


import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/services/locationgetter_service.dart';

class LocationDetector extends StatefulWidget {
  const LocationDetector({super.key});

  @override
  State<LocationDetector> createState() => _LocationDetectorState();
}

class _LocationDetectorState extends State<LocationDetector> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LocationGetter());
  }
}

class LocationGetter extends StatefulWidget {
  LocationGetter({super.key});

  @override
  State<LocationGetter> createState() => _LocationGetterState();
}

class _LocationGetterState extends State<LocationGetter> {
  DateTime dateTime = DateTime.now();
  String currentAddress = 'Getting Location..';
  final LocationgetterService locationgetterService = LocationgetterService();

  @override
  void initState() {
    super.initState();
    _setNewDateTime(dateTime);
    getLocation();
    print('InitState current address: $currentAddress');
  }

  Future<void> getLocation() async {
    try {
      Position position = await locationgetterService.getCurrentLocation();
      String address = await locationgetterService.getAddressFromLatLan(position);
      setState(() {
        currentAddress = address;
        print('Updated address: $currentAddress');
      });
    } catch (e) {
      setState(() {
        currentAddress = 'Error: $e';
        print('Error fetching location: $e');
      });
    }
  }

  void _setNewDateTime(DateTime currentTime) {
    setState(() {
      dateTime = currentTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: myHeight / 2.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/punchin.png'),
                ),
              ),
            ),
            SizedBox(height: myHeight / 50),
            AnalogClock(
              isLive: true,
              height: myHeight / 2.5,
              datetime: dateTime,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: myHeight / 25),
            Container(
              width: myWidth / 1.2,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: TextButton(
                onPressed: () async {
                  await getLocation();
                  print("Calling function, address: $currentAddress");
                  _confirmLocationDialog();
                },
                child: const Text(
                  "Punch - In",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: myHeight / 30),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmLocationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        double myHeight = MediaQuery.of(context).size.height;
        double myWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text("We found your Location"),
          content: Text(currentAddress),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {}, child: Text("Confirm")),
                TextButton(onPressed: () {}, child: Text("Edit")),
              ],
            )
          ],
        );
      },
    );
  }
}
