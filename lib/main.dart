import 'package:flutter/material.dart';
import 'package:myapp/screens/login_screen.dart';
import'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('locationBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

