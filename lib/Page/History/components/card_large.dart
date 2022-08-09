import 'dart:ui';
import 'package:flutter_music_player/helper/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CardLarge extends StatefulWidget {
  var index;
  CardLarge(this.index);
  @override
  _CardLarge createState() => _CardLarge();
}

class _CardLarge extends State<CardLarge> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      // child:
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 280.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF606060),
                      const Color(0xFF929292),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    tileMode: TileMode.clamp),
                image: DecorationImage(
                    image: NetworkImage(historyImage[widget.index]),
                    fit: BoxFit.fill)),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width - 36.w,
            height: 40.h,
            child: Container(
              decoration: BoxDecoration(),
              margin: EdgeInsets.only(left: 9.w, right: 9.w),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 20),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.w,
                  ),
                  Container(
                    width: 150.w,
                    child: Text(
                      historyName[widget.index],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35.w,
                  ),
                  Container(
                    width: 100.w,
                    child: Text(historyAr[widget.index],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                  // SizedBox(
                  //   height: 40,
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
