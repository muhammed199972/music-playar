import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_music_player/Page/Record/song_screen.dart';
import 'package:flutter_music_player/Page/Record/viewmodels/home_vm.dart';
import 'package:hooks_riverpod/all.dart';

class Recorder extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final vm = useProvider(homeViewModel);
    return ProviderListener<HomeViewModel>(
      provider: homeViewModel,
      onChange: (context, vm) {
        if (vm.success) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SongScreen(
                        song: vm.currentSong,
                      )));
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
                  'Tap to ',
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
