import 'dart:convert';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_music_player/Page/Home/modelRe.dart';
import 'package:flutter_music_player/Page/Record/song_screen.dart';
import 'package:flutter_music_player/Page/Record/viewmodels/home_vm.dart';
import 'package:flutter_music_player/helper/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/all.dart';

class Recorder extends HookWidget {
  bool isView = true;

  scheckSong(String name) async {
    Dio _dio;
    BaseOptions options = BaseOptions(baseUrl: 'http://207.154.248.155:5000/');
    _dio = Dio(options);
    try {
      if (historyName.isNotEmpty) {
        final response = await _dio.get(
          'check?song=$name',
        );
        var tt = json.decode(response.data);
        print(tt);

        tt == 0 ? isView = false : isView = true;
      } else {}
    } on DioError catch (e) {
      if (e.request != null) {
        throw 'An error has occured';
      } else {
        print(e.error);
        throw e.error;
      }
    }
  }

  SongReService(String title) async {
    Dio _dio;
    BaseOptions options = BaseOptions(baseUrl: 'http://207.154.248.155:5000/');
    _dio = Dio(options);
    try {
      final response = await _dio.get(
          "search?q=${title.toString().length > 29 ? title.toString().substring(1, 30) : title.toString()}&n_song=25");
      var tt = json.decode(response.data);
      Re result = Re.fromJson(tt);
      return await result;
    } on DioError catch (e) {
      if (e.request != null) {
        throw 'An error has occured';
      } else {
        print(e.error);
        throw e.error;
      }
    }
  }

  openSpo(String title) async {
    Dio _dio;
    BaseOptions options = BaseOptions(baseUrl: 'http://207.154.248.155:5000/');
    _dio = Dio(options);
    try {
      final response = await _dio.get("details?song=$title");
      print(response);
      var tt = json.decode(response.data);
      String result = tt["data"]["spotify"];
      return await result;
    } on DioError catch (e) {
      if (e.request != null) {
        throw 'An error has occured';
      } else {
        print(e.error);
        throw e.error;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = useProvider(homeViewModel);
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 130.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                'Oops!!',
                style: TextStyle(
                    color: Color(0xFF232528),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 14,
              ),
              child: Text(
                'Sorry The Song Not Found ',
                style: TextStyle(
                    color: Color(0xFF636363),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
          ],
        ),
      ),
    );

    return ProviderListener<HomeViewModel>(
      provider: homeViewModel,
      onChange: (context, vm) async {
        if (vm.success) {
          nameSonge.forEach((e) async {
            if (e == vm.currentSong?.title ?? '') {
              await scheckSong(e);
            }
          });

          var SongRe =
              await SongReService(vm.currentSong.title.toString() ?? "");
          var openSp = await openSpo(vm.currentSong.title.toString() ?? "");

          if (isView) {
            if (vm.currentSong.title != null) {
              await saveprefHistoryName(vm.currentSong?.title ?? '');
              await saveprefHistoryImage(vm.currentSong?.album?.coverBig ?? "");
              await saveprefHistoryAr(vm.currentSong?.artist?.name ?? '');
            }

            Future.delayed(const Duration(milliseconds: 20000), () {
              vm.stopRecognizing();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SongScreen(
                          song: vm.currentSong,
                          ListRe: SongRe,
                          openSp: openSp)));
            });
          } else {
            Future.delayed(const Duration(milliseconds: 10000), () {
              vm.stopRecognizing();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => errorDialog);
            });
          }
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF192647),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tap to find your song',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                AvatarGlow(
                  endRadius: 200.0,
                  animate: vm.isRecognizing,
                  child: GestureDetector(
                    onTap: () => vm.isRecognizing
                        ? vm.stopRecognizing()
                        : vm.startRecognizing(),
                    child: Material(
                      shape: CircleBorder(),
                      elevation: 8,
                      child: Container(
                        padding: EdgeInsets.all(40),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFC906BF)),
                        child: Image.asset(
                          'assets/image/logo.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
