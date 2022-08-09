import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/Page/History/components/card_large.dart';
import 'package:flutter_music_player/helper/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPage createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF192647),
        body: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 20.0.h, left: 10.w, right: 10.w),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30.h,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, left: 25.w, right: 25.w),
                child: Text(
                  "History",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          if (historyName.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 300.0.h),
              child: Center(
                child: Text(
                  "There is no history",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          for (int i = 0; i < historyName.length; i++)
            Container(
                height: 320.h,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 20.0.h, left: 18.w, right: 18.w),
                  child: CardLarge(i),
                )),
        ]),
      ),
    );
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
