import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/Page/Home/components/Lists_of_songs.dart';
import 'package:flutter_music_player/Page/Home/modelRe.dart';
import 'package:flutter_music_player/Page/Record/services/models/deezer_song_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SongScreen extends StatefulWidget {
  final DeezerSongModel song;
  Re ListRe;
  String openSp;
  SongScreen(
      {Key key,
      @required this.song,
      @required this.ListRe,
      @required this.openSp})
      : super(key: key);
  @override
  _SongScreen createState() => _SongScreen();
}

class _SongScreen extends State<SongScreen> {
  @override
  void initState() {
    super.initState();
  }

  _launchInBrowser(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.song?.album?.coverBig ?? ""),
                      fit: BoxFit.cover)),
              // child: Image.asset('assets/images/todd.jpg'),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(widget.song?.title ?? '',
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          height: 60.w,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: Color(0xFFC906BF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.r)),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.r)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white.withOpacity(0.3),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(-1, 0)),
                              ],
                            ),
                            child: IconButton(
                              color: Colors.blue,
                              onPressed: () {
                                print(';;;;;;;;;;;;;;');
                                print(widget.openSp);
                                print(';;;;;;;;;;;;;;');

                                _launchInBrowser(widget.openSp ?? "");
                              },
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.song?.artist?.name ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              height: 80.h,
              width: 20.w,
              child: Image(image: AssetImage('assets/image/giphy.gif')),
            ),
            if (widget.ListRe != null)
              Container(
                height: 32.h,
                padding: EdgeInsets.only(left: 25.w, top: 10.h),
                child: Text(
                  'Recommendation',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            if (widget.ListRe != null)
              Container(
                height: 320.h,
                child: ListsOfSongs(
                  ListRe: widget.ListRe,
                ),
              )
            else
              Container(
                height: 90.h,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        "Loading....",
                        style: TextStyle(
                            color: Color(0xFF263E7C),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
