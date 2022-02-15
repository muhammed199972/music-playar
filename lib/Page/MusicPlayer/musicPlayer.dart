import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player_tutorial/Page/Home_page/homePage.dart';
import 'package:music_player_tutorial/database.dart';

class MusicPlayer extends StatelessWidget {
  final Song song;
  MusicPlayer(this.song);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(song.image), fit: BoxFit.cover)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Pathway",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("India", style: TextStyle(fontSize: 10))
                  ],
                ),
              ),
            ],
          ),
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  spreadRadius: 16,
                  color: Colors.black.withOpacity(0.2),
                )
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: 1.5, color: Colors.white.withOpacity(0.2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                song.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            song.singer,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 2),
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 6),
                            child: Slider(
                              value: currentSlider,
                              max: song.duration.toDouble(),
                              min: 0,
                              inactiveColor: Colors.white70,
                              activeColor: Colors.red,
                              onChanged: (val) {
                                currentSlider = val;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Duration(seconds: currentSlider.toInt())
                                    .toString()
                                    .split('.')[0]
                                    .substring(2),
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                Duration(seconds: song.duration.toInt())
                                    .toString()
                                    .split('.')[0]
                                    .substring(2),
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.skip_previous_outlined,
                                color: Colors.white, size: 40),
                            Icon(Icons.pause, color: Colors.white, size: 50),
                            Icon(Icons.skip_next_outlined,
                                color: Colors.white, size: 40)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
