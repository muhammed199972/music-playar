import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/Page/Home/components/ListSonde.dart';
import 'package:flutter_music_player/Page/Home/components/Lists_of_songs.dart';
import 'package:flutter_music_player/Page/Home/components/card_large.dart';
import 'package:flutter_music_player/Page/Search/searchMy.dart';
import 'package:flutter_music_player/helper/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getpref();
    setupAudio();
  }

  void setupAudio() {
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          _slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = audioManagerInstance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          audioManagerInstance.updateLrc(args["position"].toString());
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF192647),
        body: Stack(children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
                  child: Text(
                    "Hello Dear",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "what you want to hear today ?",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (songInfo.isNotEmpty)
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SearchPage(
                          songList: songInfo,
                        );
                      }));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Color(0xFF263E7C),
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.search,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'Search in music',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    //  TextField(decoration: InputDecoration(labelText: 'Search',fillColor: Colors.orange,focusColor:  Colors.orange),)
                  ),
                ),
                Container(
                  height: 233.h,
                  child: ListsOfSongs(),
                ),
                Container(
                  height: 32.h,
                  padding: EdgeInsets.only(left: 25.w, top: 10.h),
                  child: Text(
                    'My Music',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                FutureBuilder(
                  future: FlutterAudioQuery()
                      //.getAlbums(),
                      .getSongs(sortType: SongSortType.RECENT_YEAR),
                  builder: (context, snapshot) {
                    songInfo = snapshot.data;
                    if (snapshot.hasData)
                      return Container(
                        height: songInfo.length * 80.toDouble(),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListSonde(songList: songInfo),
                        ),
                      );
                    return Container(
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
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF192647),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r))),
                  height: 127.h,
                  width: 380.w,
                  padding: EdgeInsets.only(top: 20.h),
                  child: bottomPanel())),
        ]),
      ),
    );
  }

  Widget songProgress(BuildContext context) {
    TextStyle style = TextStyle(color: Colors.white);
    return Row(
      children: <Widget>[
        Text(
          formatDuration(audioManagerInstance.position),
          style: style,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8.h,
                  thumbColor: Color(0xFFC906BF),
                  overlayColor: Color(0xFFC906BF),
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 15.r,
                    enabledThumbRadius: 10.r,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Color(0xFFC906BF),
                  inactiveTrackColor: Color(0xFF263E7C),
                ),
                child: Slider(
                  value: _slider ?? 0,
                  onChanged: (value) {
                    setState(() {
                      _slider = value;
                    });
                  },
                  onChangeEnd: (value) {
                    if (audioManagerInstance.duration != null) {
                      Duration msec = Duration(
                          milliseconds:
                              (audioManagerInstance.duration.inMilliseconds *
                                      value)
                                  .round());
                      audioManagerInstance.seekTo(msec);
                    }
                  },
                )),
          ),
        ),
        Text(
          formatDuration(audioManagerInstance.duration),
          style: style,
        ),
      ],
    );
  }

  Widget bottomPanel() {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: songProgress(context),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    play - 1 < 0 ? play = songInfo.length - 1 : play = play - 1;
                    audioManagerInstance.previous();
                  }),
            ),
            Container(
              height: 65.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: Color(0xFFC906BF),
                borderRadius: BorderRadius.all(Radius.circular(100.r)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.r)),
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
                  onPressed: () async {
                    audioManagerInstance.playOrPause();
                  },
                  icon: Icon(
                    audioManagerInstance.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // CircleAvatar(
            //   backgroundColor: Colors.blue,
            //   radius: 30,
            //   child: Center(
            //     child: IconButton(
            //       color: Colors.blue,
            //       onPressed: () async {
            //         audioManagerInstance.playOrPause();
            //       },
            //       padding: const EdgeInsets.all(0.0),
            //       icon: Icon(
            //         audioManagerInstance.isPlaying
            //             ? Icons.pause
            //             : Icons.play_arrow,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            Center(
              child: IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    songInfo.length - 1 < play + 1 ? play = 0 : play = play + 1;
                    audioManagerInstance.next();
                  }),
            ),
          ],
        ),
      ),
    ]);
  }
}

String formatDuration(Duration d) {
  if (d == null) return "--:--";
  int minute = d.inMinutes;
  int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
  String format = ((minute < 10) ? "0$minute" : "$minute") +
      ":" +
      ((second < 10) ? "0$second" : "$second");
  return format;
}

var audioManagerInstance = AudioManager.instance;
bool showVol = false;
PlayMode playMode = audioManagerInstance.playMode;
bool isPlaying = false;
double _slider;
