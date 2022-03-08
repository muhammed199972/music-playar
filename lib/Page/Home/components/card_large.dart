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
        return GestureDetector(
          onTap: () {},
          // child:
            child: Stack(children: [
              Container(
            margin: EdgeInsets.all(10),
            height: 280,
            width: MediaQuery.of(context).size.width -80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFC906BF),
                      blurRadius: 1,
                      spreadRadius: 0.3)
                ],
                image: DecorationImage(
                    image: AssetImage('assets/image/icon_music.jpg'),
                    fit: BoxFit.cover)
                ),
              ),
              // Image.asset(mostPopular[index].image,fit: BoxFit.cover,),
              Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Null",
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
            // Column(children: [Row(children: [
            //   Container(child: ClipRRect(child:BackdropFilter(filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),
            // child: Container(width: 40,height: 40,color: Colors.transparent,child: Text("ssssssssss"),
            // ),),),)
            // ],)],)
            Positioned(bottom: 0,width: MediaQuery.of(context).size.width -60,height: 40,child:Container(
              decoration: BoxDecoration(
                ),
              margin:EdgeInsets.only(left: 9,right: 9) ,
              child:ClipRRect(
                borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)) ,
                child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 7,sigmaY: 20),
            child: Container(color: Colors.transparent,
            ),),)  ,),
            )
            ],), 
            
          
         
          
          
        );
      },
    );
  }
}
