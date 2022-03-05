import 'package:shared_preferences/shared_preferences.dart';

List fav = [];
savepref(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  fav = await preferences.getStringList("Favorite");
  fav.add(name);
  await preferences.setStringList("Favorite", []);
}

getpref() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  try {
    fav = await preferences.getStringList("Favorite");
    print(';;;;;;;;;;;;;;;;;;;;');
  } catch (e) {}
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
