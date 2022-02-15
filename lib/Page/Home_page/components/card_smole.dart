import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_tutorial/Page/MusicPlayer/musicPlayer.dart';
import 'package:music_player_tutorial/database.dart';

class CardSmole extends StatelessWidget {
  Song currentSong = Song(
      name: "title",
      singer: "singer",
      image: "assets/song1.jpg",
      duration: 100,
      color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        var fav = false.obs;
        var pause = false.obs;
        return GestureDetector(
            onTap: () {
              Get.to(MusicPlayer(currentSong));
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: -16,
                    blurRadius: 27,
                    offset: const Offset(0, 13), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        //   margin: EdgeInsets.all(10),
                        width: 120,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage(mostPopular[index].image),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mostPopular[index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(mostPopular[index].singer,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    Obx(() {
                      return Expanded(
                        child: IconButton(
                            onPressed: () {
                              pause.value
                                  ? pause.value = false
                                  : pause.value = true;
                            },
                            icon: Icon(pause.value
                                ? Icons.skip_next_outlined
                                : Icons.pause)),
                      );
                    }),
                    Obx(() {
                      return Expanded(
                        child: IconButton(
                            onPressed: () {
                              fav.value ? fav.value = false : fav.value = true;
                            },
                            icon: Icon(fav.value
                                ? Icons.favorite
                                : Icons.favorite_border)),
                      );
                    })
                  ]),
            ));
      },
    );
  }
}
