import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_music_player/Page/Record/services/models/deezer_song_model.dart';
import 'package:flutter_music_player/Page/Record/services/song_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    initAcr();
  }
  final AcrCloudSdk acr = AcrCloudSdk();
  final songService = SongService();
  DeezerSongModel currentSong;
  bool isRecognizing = false;
  bool success = false;

  Future<void> initAcr() async {
    try {
      acr
        ..init(
          host: 'identify-eu-west-1.acrcloud.com', // https://www.acrcloud.com/
          accessKey: 'f13905283acfcf832c963029be1e57aa',
          accessSecret: 'q5icpEuz4OW6pkAYVstZbJ0ej9knJOtBj4Tnqn4j',
          setLog: true,
        )
        ..songModelStream.listen(searchSong);
    } catch (e) {
      print(e.toString());
    }
  }

  void searchSong(SongModel song) async {
    print(song);
    final metaData = song?.metadata;
    if (metaData != null && metaData.music.length > 0) {
      final trackId = metaData?.music[0]?.externalMetadata?.deezer?.track?.id;
      try {
        final res = await songService.getTrack(trackId);
        currentSong = res;
        success = true;
        notifyListeners();
      } catch (e) {
        isRecognizing = false;
        success = false;
        notifyListeners();
      }
    }
  }

  Future<void> startRecognizing() async {
    isRecognizing = true;
    success = false;
    notifyListeners();
    try {
      await acr.start();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> stopRecognizing() async {
    isRecognizing = false;
    success = false;
    notifyListeners();
    try {
      await acr.stop();
    } catch (e) {
      print(e.toString());
    }
  }
}

final homeViewModel = ChangeNotifierProvider<HomeViewModel>((ref) {
  print('>>> In homeViewModel');
  return HomeViewModel();
});
