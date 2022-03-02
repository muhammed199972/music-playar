import 'package:flutter/material.dart';
import 'package:music_player_tutorial/Page/Home_page/components/card_large.dart';
import 'package:music_player_tutorial/Page/Home_page/components/card_smole.dart';
import 'package:music_player_tutorial/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: Text(
                      "How are you feeling",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "today ?",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 40, bottom: 10),
                    child: Text(
                      "Albums",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: CardLarge(refresh),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                    child: Text(
                      "Recomendation",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: CardLarge(refresh),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                    child: Text(
                      "Songs",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 400,
                    child: CardSmole(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  refresh() {
    setState(() {});
  }
}

Song currentSong = Song(
    name: "title",
    singer: "singer",
    image: "assets/song1.jpg",
    duration: 100,
    color: Colors.black);
double currentSlider = 0;
