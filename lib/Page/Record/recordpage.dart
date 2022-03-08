import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'dart:math';



class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = new Color.fromRGBO(0, 117, 194, opacity);

    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = new Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}

class Recorder extends StatefulWidget {
  Recorder({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyRecorderState createState() => _MyRecorderState();
}

class _MyRecorderState extends State<Recorder> 
with SingleTickerProviderStateMixin{
  FlutterSoundRecorder _myRecorder;
  AnimationController _controller;
  final audioPlayer = AssetsAudioPlayer();
  String filePath;
  bool recording ;
  // bool _play = false;
  // String _recorderTxt = '00:00:00';

  @override
  void initState() {
    super.initState();
     _controller = new AnimationController(
      vsync: this,);
      recording = false;
    startIt();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }
  void _stopAnimation() {
    _controller.stop();
    
  }

  void startIt() async {
    filePath = '/sdcard/Download/temp.wav';
    _myRecorder = FlutterSoundRecorder();


    await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();
    
    
    await Permission.microphone.request();
    PermissionStatus permission = await Permission.microphone.status;

      if (permission == PermissionStatus.granted) {
        print("tacked");
      }
      else
      print("not tacked");
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF192647),
      // appBar: AppBar(title: Text(''),),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10,top: 15),
                  child: Text(
                    "Record...",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
            ],),
            
            
            Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/5,
            right: MediaQuery.of(context).size.width/5,
            top: MediaQuery.of(context).size.width/2.5),
            child: CustomPaint(
        painter: SpritePainter(_controller),
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: InkWell(onTap: (){
            setState(() {
                          
                        
            if(!recording){
            _startAnimation();
            print(recording);
            record();
            recording = true;
          }
          else
          {
            _stopAnimation();
            print(recording);
            stopRecord();
            recording = false;
          }});
                        
          },child: recording
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
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
                                            Radius.circular(100)),
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
                                    ),),
        ),
      ),),
             
          ],
        ),
      
    ));
  }

  Future<void> record() async {
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder.openAudioSession();
    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

  }

  Future<String> stopRecord() async {
    _myRecorder.closeAudioSession();
    return await _myRecorder.stopRecorder();
  }

  // Future<void> startPlaying() async {
  //   audioPlayer.open(
  //     Audio.file(filePath),
  //     autoStart: true,
  //     showNotification: true,
  //   );
  // }

  // Future<void> stopPlaying() async {
  //   audioPlayer.stop();
  // }
}
