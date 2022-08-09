import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> fav = [];
List<SongInfo> songInfo = [];
List<SongInfo> searchSong = [];
List<String> historyName = [];
List<String> historyImage = [];
List<String> historyAr = [];
List<String> historyUrl = [];
List<String> nameSonge = [
  "Shape of You",
  "In the End",
  "The Search",
  "Maek Alby",
  "Etnaset",
  "Kelna Mnenjar"
];

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

saveprefHistoryName(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  historyName = await preferences.getStringList("HistoryName");
  if (historyName == null) {
    historyName = [];
  }
  bool isEm = true;
  for (int i = 0; i < historyName.length; i++) {
    if (historyName[i] == name) {
      isEm = false;
      break;
    }
  }
  if (isEm) {
    print(name);
    historyName.add(name);
    await preferences.setStringList("HistoryName", historyName);
    getprefHistoryName();
  }
}

getprefHistoryName() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  historyName = await preferences.getStringList("HistoryName");
  if (historyName == null) {
    historyName = [];
  }
}

saveprefHistoryImage(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  historyImage = await preferences.getStringList("HistoryImage");
  if (historyImage == null) {
    historyImage = [];
  }
  bool isEm = true;
  for (int i = 0; i < historyImage.length; i++) {
    if (historyImage[i] == name) {
      isEm = false;
      break;
    }
  }
  if (isEm) {
    print(name);
    historyImage.add(name);
    await preferences.setStringList("HistoryImage", historyImage);
    getprefHistoryImage();
  }
}

getprefHistoryImage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  historyImage = await preferences.getStringList("HistoryImage");
  if (historyImage == null) {
    historyImage = [];
  }
}

saveprefHistoryAr(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  historyAr = await preferences.getStringList("HistoryAr");
  if (historyAr == null) {
    historyAr = [];
  }

  bool isEm = true;
  for (int i = 0; i < historyAr.length; i++) {
    if (historyAr[i] == name) {
      isEm = false;
      break;
    }
  }
  if (isEm) {
    print(name);
    historyAr.add(name);
    await preferences.setStringList("HistoryAr", historyAr);
    getprefHistoryAr();
  }
}

getprefHistoryAr() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  historyAr = await preferences.getStringList("HistoryAr");
  if (historyAr == null) {
    historyAr = [];
  }
}

saveprefHistoryUrl(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  historyUrl = await preferences.getStringList("HistoryUrl");
  if (historyUrl == null) {
    historyUrl = [];
  }

  bool isEm = true;
  for (int i = 0; i < historyUrl.length; i++) {
    if (historyUrl[i] == name) {
      isEm = false;
      break;
    }
  }
  if (isEm) {
    print(name);
    historyUrl.add(name);
    await preferences.setStringList("HistoryUrl", historyUrl);
    getprefHistoryUrl();
  }
}

getprefHistoryUrl() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  historyUrl = await preferences.getStringList("HistoryUrl");
  if (historyUrl == null) {
    historyUrl = [];
  }
}
