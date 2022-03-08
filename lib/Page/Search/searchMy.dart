import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/Page/Home/components/ListSonde.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  final List<SongInfo> songList;
  SearchPage({@required this.songList});
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  List<SongInfo> songInfo = [];

  @override
  void initState() {
    songInfo = widget.songList;
    super.initState();
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

  bool isData(String value) {
    var data = widget.songList
        .where((element) => (element.title.contains(value)))
        .toList();
    if (data.length >= 1) {
      songInfo = [];
      setState(() {
        for (int j = 0; j < data.length; j++) {
          for (int i = 0; i < widget.songList.length; i++) {
            if (data[j].id == widget.songList[i].id) {
              songInfo.add(widget.songList[i]);
            }
          }
        }
      });
    } else {
      setState(() {
        songInfo = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(songInfo.length);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF192647),
        body: Stack(children: [
          Positioned(
            top: 0.h,
            child: Container(
              padding: EdgeInsets.all(20),
              height: 100.h,
              width: 377.w,
              child: TextField(
                onChanged: (e) {
                  setState(() {
                    isData(e);
                  });
                },
                autofocus: false,
                style: TextStyle(fontSize: 22.0, color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  icon: Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.white,
                  ),
                  fillColor: Color(0xFF263E7C),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF263E7C)),
                    borderRadius: BorderRadius.circular(12.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF263E7C)),
                    borderRadius: BorderRadius.circular(12.7),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80.h,
            child: SizedBox(
                height: 700.h,
                width: 377.w,
                child: ListView(
                  children: <Widget>[
                    Container(
                        height: songInfo.length * 80.toDouble(),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListSonde(songList: songInfo),
                        ))
                  ],
                )),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF192647),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r))),
                  height: 112.h,
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
                  inactiveTrackColor: Color(0xFF1C2C53),
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
              height: 50.h,
              width: 45.w,
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
