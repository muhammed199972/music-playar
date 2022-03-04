import 'package:flutter/material.dart';
import 'package:music_player_tutorial/Page/Home_page/homePage.dart';
import 'package:music_player_tutorial/database.dart';

class ListsOfSongs extends StatefulWidget {
  // final Function() notifyParent;
  // ListsOfSongs(this.notifyParent);
  @override
  _ListsOfSongsState createState() => _ListsOfSongsState();
}

class _ListsOfSongsState extends State<ListsOfSongs> {

// class ListsOfSongs extends StatelessWidget {

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
            currlist = index;
            print(currlist);
            setState(() {});
            // currentSlider = 0;
            // super.notifyParent();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: index == currlist? Column(children: [
              Text(song_lists[index],style: TextStyle( 
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),)
                          ,SizedBox(
                          height: 10,
                          )
                          ,Container(
                          alignment: Alignment.center,
                          // padding: EdgeInsets.all( 30),
                          width: 30,height:4,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(begin: Alignment.centerLeft,
                                  end : Alignment.centerRight,stops:[0.4,1], 
                                  colors: [Colors.deepPurple.shade900,Colors.deepPurple.shade400] )))
            ],):Column(children: [
              Padding(padding: EdgeInsets.only(top: 7) ,
              child:Text(song_lists[index],style: TextStyle( 
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white54),) ,) 
            ],) ,
          ),
        );
      },
    );
  }
}
