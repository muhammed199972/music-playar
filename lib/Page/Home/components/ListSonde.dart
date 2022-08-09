import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/Page/Home/homepage.dart';
import 'package:flutter_music_player/helper/constant.dart';
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
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.songList.length,
        itemBuilder: (context, songIndex) {
          SongInfo song = widget.songList[songIndex];
          String format = (int.parse(song.duration) / 65170).toString();
          var formattime = format.split('.');
          bool favorite = false;

          for (int i = 0; i < fav.length; i++) {
            if (fav[i] == song.title.toString()) {
              favorite = true;
            }
          }
          var nameartist = song.artist.length < 12
              ? song.artist.substring(0, song.artist.length)
              : song.artist.substring(0, 12) + '...';
          var namesong = song.title.length < 9
              ? song.title.substring(0, song.title.length)
              : song.title.substring(0, 9) + '...';

          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
                width: 350.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: Color(0xFF263E7C),
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
                        height: 80.h,
                        width: 80.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120.w,
                              child: Text(
                                namesong,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Text(
                              "Artist ${nameartist}",
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (favorite) {
                                deletepref(song.title.toString());
                              } else {
                                savepref(song.title.toString());
                              }
                            });
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFC906BF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.r)),
                            ),
                            child: favorite
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
                                      Icons.favorite,
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
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
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
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFC906BF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.r)),
                            ),
                            child: play == songIndex &&
                                    audioManagerInstance.isPlaying
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
