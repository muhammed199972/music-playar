// import 'package:flutter/material.dart';
// import 'package:flutter_music_player/Page/Favorite/favorite.dart';
// import 'package:flutter_music_player/Page/Home/homepage.dart';
// import 'package:flutter_music_player/Page/Search/search.dart';
// import 'package:rolling_nav_bar/rolling_nav_bar.dart';
// import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

// class navbar extends StatefulWidget {
//   @override
//   _navbar createState() => _navbar();
// }

// class _navbar extends State<navbar> {
//   PageController _pageController;
//   int selectedIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: selectedIndex);
//   }

//   void onButtonPressed(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//     _pageController.animateToPage(selectedIndex,
//         duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: PageView(
//               physics: const NeverScrollableScrollPhysics(),
//               controller: _pageController,
//               children: _listOfWidget,
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar:RollingNavBar.iconData(
//   animationCurve: Curves.easeOut,  // `easeOut` (the default) is recommended here
//   animationType: AnimationType.roll,
//   baseAnimationSpeed: 200, // milliseconds
//   iconData: <IconData>[
//     ...
//   ],
// )

import 'dart:async';

import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/Page/Favorite/favorite.dart';
import 'package:flutter_music_player/Page/Home/homepage.dart';
import 'package:flutter_music_player/Page/Record/recordpage.dart';
import 'package:flutter_music_player/Page/Search/search.dart';

class Navbar extends StatefulWidget {
  int _currentPage = 0;
  int currentPage = 0;
  Navbar(this._currentPage, this.currentPage);
  @override
  _Navbar createState() => _Navbar();
}

class _Navbar extends State<Navbar> with TickerProviderStateMixin {
  static const int totalPage = 4;

  @override
  void initState() {
    super.initState();
  }

  var page = [
    HomePage(),
    SearchAllPage(
      songList: [],
    ),
    FavoritePage(),
    Recorder()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF192647),
      body: BottomBarPageTransition(
        builder: (_, index) => page[index],
        currentIndex: widget._currentPage,
        totalLength: totalPage,
        transitionType: transitionType,
        transitionDuration: duration,
        transitionCurve: curve,
      ),
      bottomNavigationBar: _getBottomBar(),
    );
  }

  Widget _getBottomBar() {
    return BottomNavigationBar(
      currentIndex: widget._currentPage,
      backgroundColor: Color(0xFF192647),
      onTap: (index) {
        widget._currentPage = index;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            widget.currentPage = index;
          });
        });
      },
      selectedItemColor: Color(0xFFC906BF),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: widget.currentPage == 0
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const RadialGradient(
                      center: Alignment.bottomLeft,
                      radius: 1.5,
                      colors: <Color>[
                        Color(0xFFC906BF),
                        Color(0xFF8B66C2),
                      ],
                      tileMode: TileMode.repeated,
                    ).createShader(bounds);
                  },
                  child: Icon(Icons.home),
                )
              : Icon(Icons.home, color: Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: widget.currentPage == 1
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const RadialGradient(
                      center: Alignment.bottomLeft,
                      radius: 1.5,
                      colors: <Color>[
                        Color(0xFFC906BF),
                        Color(0xFF8F6CC4),
                      ],
                      tileMode: TileMode.repeated,
                    ).createShader(bounds);
                  },
                  child: Icon(Icons.search),
                )
              : Icon(Icons.search, color: Colors.grey),
          label: 'search',
        ),
        BottomNavigationBarItem(
          icon: widget.currentPage == 2
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const RadialGradient(
                      center: Alignment.bottomLeft,
                      radius: 1.5,
                      colors: <Color>[
                        Color(0xFFC906BF),
                        Color(0xFF8F6CC4),
                      ],
                      tileMode: TileMode.repeated,
                    ).createShader(bounds);
                  },
                  child: Icon(Icons.turned_in_rounded),
                )
              : Icon(Icons.turned_in_rounded, color: Colors.grey),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: widget.currentPage == 3
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const RadialGradient(
                      center: Alignment.bottomLeft,
                      radius: 1.5,
                      colors: <Color>[
                        Color(0xFFC906BF),
                        Color(0xFF8F6CC4),
                      ],
                      tileMode: TileMode.repeated,
                    ).createShader(bounds);
                  },
                  child: Icon(Icons.radio_button_checked),
                )
              : Icon(Icons.radio_button_checked, color: Colors.grey),
          label: 'voice',
        ),
      ],
    );
  }

  Duration duration = const Duration(milliseconds: 100);
  Curve curve = Curves.ease;
  TransitionType transitionType = TransitionType.circular;
}

      
//        SlidingClippedNavBar(
//         backgroundColor: Color(0xFF192647),
//         onButtonPressed: onButtonPressed,
//         iconSize: 32,
//         activeColor: Color(0xFFC906BF),
//         inactiveColor: Color(0xFFC906BF),
//         selectedIndex: selectedIndex,
//         barItems: <BarItem>[
//           BarItem(
//             icon: Icons.home,
//             title: 'Home',
//           ),
//           BarItem(
//             icon: Icons.search_rounded,
//             title: 'Search',
//           ),
//           BarItem(
//             icon: Icons.favorite,
//             title: 'Favorite',
//           ),
//           BarItem(
//             icon: Icons.tune_rounded,
//             title: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // icon size:24 for fontAwesomeIcons
// // icons size: 30 for MaterialIcons

// List<Widget> _listOfWidget = <Widget>[
//   HomePage(),
//   SearchAllPage(
//     songList: [],
//   ),
//   FavoritePage(),
//   Container(
//     alignment: Alignment.center,
//     child: const Icon(
//       Icons.tune_rounded,
//       size: 56,
//       color: Colors.brown,
//     ),
//   ),
// ];
