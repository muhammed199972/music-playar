import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/Page/Home/components/card_large.dart';
import 'package:flutter_music_player/Page/Home/modelRe.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListsOfSongs extends StatefulWidget {
  Re ListRe;
  ListsOfSongs({@required this.ListRe});
  @override
  _ListsOfSongsState createState() => _ListsOfSongsState();
}

class _ListsOfSongsState extends State<ListsOfSongs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 25.h,
      ),
      Container(
        height: 250.h,
        child: CardLarge(widget.ListRe),
      ),
    ]);
  }
}
