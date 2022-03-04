import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_tutorial/Page/Navbar/navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: Colors.purple,),
      title: 'Music Player',

      debugShowCheckedModeBanner: false,
      home: navbar(),
    );
  }
}
