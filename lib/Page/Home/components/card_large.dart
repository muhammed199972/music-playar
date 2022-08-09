import 'dart:ui';
import 'package:flutter_music_player/Page/Home/modelRe.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardLarge extends StatefulWidget {
  Re listitems;
  CardLarge(this.listitems);
  @override
  _CardLarge createState() => _CardLarge();
}

class _CardLarge extends State<CardLarge> {
  _launchInBrowser(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listitems.data.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _launchInBrowser(widget.listitems.data[index].spotify);
          },
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 280.h,
                width: MediaQuery.of(context).size.width - 80.w,
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
                        image: NetworkImage(widget.listitems.data[index].image),
                        fit: BoxFit.fill)),
              ),
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width - 60.w,
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
                  width: MediaQuery.of(context).size.width - 50.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                        width: 180.w,
                        child: Text(
                          widget.listitems.data[index].name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        width: 60.w,
                        child: Text(widget.listitems.data[index].artists,
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
      },
    );
  }
}
