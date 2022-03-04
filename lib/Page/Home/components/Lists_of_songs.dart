import 'package:flutter/material.dart';

class ListsOfSongs extends StatefulWidget {
  @override
  _ListsOfSongsState createState() => _ListsOfSongsState();
}

class _ListsOfSongsState extends State<ListsOfSongs> {
  List<String> song_lists = ["mostPopular", "newRelease", "recommendation"];
  int currlist = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: song_lists.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currlist = index;
            });
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  song_lists[index],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: 30,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [
                              0.4,
                              1
                            ],
                            colors: [
                              index != currlist
                                  ? Colors.transparent
                                  : Colors.deepPurple.shade900,
                              index != currlist
                                  ? Colors.transparent
                                  : Colors.deepPurple.shade400
                            ])))
              ],
            ),
          ),
        );
      },
    );
  }
}
