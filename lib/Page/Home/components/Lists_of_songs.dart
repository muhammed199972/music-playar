import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/Page/Home/components/card_large.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListsOfSongs extends StatefulWidget {
  @override
  _ListsOfSongsState createState() => _ListsOfSongsState();
}

class _ListsOfSongsState extends State<ListsOfSongs> {
  List<String> songListsItem = [
    'albom',
    "recommendation",
    "mostPopular",
    "newRelease",
  ];
  int currlist = 0;
  var songLists;
  @override
  void initState() {
    super.initState();
    getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListView.builder(
        itemCount: songListsItem.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() async {
                currlist = index;
                if (index == 0) {
                  await getAlbums();
                }
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    songListsItem[index],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 30,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [
                                0.4,
                                1
                              ],
                              colors: [
                                index != currlist
                                    ? Colors.transparent
                                    : Colors.deepPurple.shade900,
                                index != currlist
                                    ? Colors.transparent
                                    : Colors.deepPurple.shade400
                              ])))
                ],
              ),
            ),
          );
        },
      ),
      Container(
        height: 175.h,
        child: CardLarge(songLists),
      ),
    ]);
  }

  getAlbums() {
    songLists = FlutterAudioQuery().getAlbums();
    print(songLists);
  }
}
