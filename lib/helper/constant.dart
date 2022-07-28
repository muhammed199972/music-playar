import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> fav = [];
List<SongInfo> songInfo = [];
List<SongInfo> searchSong = [];

savepref(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  fav = await preferences.getStringList("Favorite");
  if (fav == null) {
    fav = [];
  }
  print(name);
  fav.add(name);
  await preferences.setStringList("Favorite", fav);
  getpref();
}

getpref() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  fav = await preferences.getStringList("Favorite");
  if (fav == null) {
    fav = [];
  }
}

deletepref(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  fav = await preferences.getStringList("Favorite");
  for (int i = 0; i < fav.length; i++) {
    if (fav[i] == name) {
      fav.removeAt(i);
    }
  }
  await preferences.setStringList("Favorite", fav);
}
