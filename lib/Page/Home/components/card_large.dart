import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CardLarge extends StatefulWidget {
  var listitems;
  CardLarge(this.listitems);
  @override
  _CardLarge createState() => _CardLarge();
}

class _CardLarge extends State<CardLarge> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: index == 3
              ? EdgeInsets.only(left: 20.w, right: 20.w)
              : EdgeInsets.only(
                  left: 20.w,
                ),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 270.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFC906BF),
                        blurRadius: 1,
                        spreadRadius: 0.3)
                  ],
                  image: DecorationImage(
                      image: new AssetImage('assets/image/icon_music.jpg'),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
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
                  Positioned(
                    child: Container(
                      height: 280,
                      width: MediaQuery.of(context).size.width - 80,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
