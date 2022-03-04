import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/Home/homepage.dart';
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

int play = 10000000;
bool playicon = false;

class ListSonde extends StatefulWidget {
  final List<SongInfo> songList;
  ListSonde({@required this.songList});
  @override
  _ListSonde createState() => _ListSonde();
}

class _ListSonde extends State<ListSonde> {
  @override
  Widget build(BuildContext context) {
    print(playicon);
    return ListView.builder(
        itemCount: widget.songList.length,
        itemBuilder: (context, songIndex) {
          SongInfo song = widget.songList[songIndex];
          String format = (int.parse(song.duration) / 65170).toString();

          var formattime = format.split('.');

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
                width: 350.w,
                decoration: BoxDecoration(
                  color: Color(0xFF1C2C53),
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                child: Container(
                  width: 350.w,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                            image: new DecorationImage(
                              image:
                                  new AssetImage('assets/image/icon_music.jpg'),
                              fit: BoxFit.fill,
                            )),
                        height: 80,
                        width: 80,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5.h),
                            width: 180.w,
                            child: Text(
                              song.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          // Text(
                          //   "Realse year ${song.year}",
                          //   style: TextStyle(
                          //       fontSize: 11,
                          //       color: Colors.grey,
                          //       fontWeight: FontWeight.w500),
                          // ),
                          Text(
                            "Artist ${song.artist}",
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(children: [
                            play == songIndex
                                ? Text(
                                    formatDuration(
                                            audioManagerInstance.position) +
                                        ' /',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                : Text(
                                    '00:00 /',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                            SizedBox(
                              width: 5.h,
                            ),
                            Text(
                              formattime[0].length > 1
                                  ? "${formattime[0]}:${formattime[1].substring(0, 2)}"
                                  : "0${formattime[0]}:${formattime[1].substring(0, 2)}",
                              style: TextStyle(color: Color(0xFFC906BF)),
                            ),
                          ]),
                          // Text(
                          //   "Duration ${Parsetominsec(int.parse(song.duration))}",
                          //   style: TextStyle(
                          //       fontSize: 11,
                          //       color: Colors.grey,
                          //       fontWeight: FontWeight.w500),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (play == songIndex) {
                                playicon ? playicon = false : playicon = true;
                                audioManagerInstance.playOrPause();
                              } else {
                                playicon = true;
                                play = songIndex;
                                audioManagerInstance.start(
                                    "file://${song.filePath}", song.title);
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFC906BF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.r)),
                            ),
                            child: play == songIndex && playicon
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.r)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 2,
                                            offset: Offset(-1, 0)),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.r)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 2,
                                            offset: Offset(-1, 0)),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
