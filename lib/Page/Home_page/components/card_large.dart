import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player_tutorial/Page/Home_page/homePage.dart';
import 'package:music_player_tutorial/database.dart';

class CardLarge extends StatelessWidget {
  final Function() notifyParent;
  CardLarge(this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mostPopular.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            currentSong = mostPopular[index];
            currentSlider = 0;
            notifyParent();
          },
          child:Container(
            margin: EdgeInsets.all(10),
            height: 280,
            width: MediaQuery.of(context).size.width -80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: mostPopular[index].color,
                      blurRadius: 1,
                      spreadRadius: 0.3)
                ],
                image: DecorationImage(
                    image: AssetImage(mostPopular[index].image),
                    fit: BoxFit.cover)
                ),
            child: Stack(children: [
              // Image.asset(mostPopular[index].image,fit: BoxFit.cover,),
            //   Padding(
            //   padding: EdgeInsets.all(8),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         mostPopular[index].name,
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       Text(mostPopular[index].singer,
            //           style: TextStyle(
            //               color: Colors.white54,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 12)),
            //       SizedBox(
            //         height: 20,
            //       )
            //     ],
            //   ),
            // ),
            Positioned(child:Container(height: 280,
            width: MediaQuery.of(context).size.width -80,
              child:BackdropFilter(filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),
            child: Container(color: Colors.transparent,
            ),) ,),
            )
            ],), 
            
          ),
         
          
          
        );
      },
    );
  }
}
