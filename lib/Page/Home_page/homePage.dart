import 'package:flutter/material.dart';
import 'package:music_player_tutorial/Page/Home_page/components/card_large.dart';
import 'package:music_player_tutorial/Page/Home_page/components/card_smole.dart';
import 'package:music_player_tutorial/Page/Home_page/components/Lists_of_songs.dart';

import 'package:music_player_tutorial/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   int currSong = 0;
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 30,bottom: 10),
                    child: Text(
                      "Hello...",
                      style: TextStyle( 
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "what you want to hear today ?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10),child: 
                  TextField(
                    autofocus: false,
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.purple,
                      hintText: 'Search',
                      contentPadding:
                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(12.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(12.7),
                      ),
                    ),
                  ),
                  //  TextField(decoration: InputDecoration(labelText: 'Search',fillColor: Colors.orange,focusColor:  Colors.orange),)
                  ),
                  Container(
                    height: 70,
                    child: ListsOfSongs(),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 20, top: 40, bottom: 10),
                  //   child: Text(
                  //     "Albums",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //         fontSize: 18),
                  //   ),
                  // ),
                  Container(
                    height: 300,
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
    print("sssssssssssssssssssss");
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
