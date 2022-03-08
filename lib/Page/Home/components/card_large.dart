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
                  image: DecorationImage(
                      image: new AssetImage('assets/image/icon_music.jpg'),
                      fit: BoxFit.cover)),
            ),
          ),
        );
      },
    );
  }
}
