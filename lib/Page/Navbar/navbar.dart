import 'package:flutter/material.dart';
import 'package:flutter_music_player/Page/Home/homepage.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class navbar extends StatefulWidget {
  @override
  _navbar createState() => _navbar();
}

class _navbar extends State<navbar> {
  PageController _pageController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Color(0xFF192647),
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        activeColor: Color(0xFFC906BF),
        inactiveColor: Color(0xFFC906BF),
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.search_rounded,
            title: 'Search',
          ),
          BarItem(
            icon: Icons.favorite,
            title: 'Energy',
          ),
          BarItem(
            icon: Icons.tune_rounded,
            title: 'Settings',
          ),
        ],
      ),
    );
  }
}

// icon size:24 for fontAwesomeIcons
// icons size: 30 for MaterialIcons

List<Widget> _listOfWidget = <Widget>[
  HomePage(),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.search,
      size: 56,
      color: Colors.brown,
    ),
  ),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.bolt,
      size: 56,
      color: Colors.brown,
    ),
  ),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.tune_rounded,
      size: 56,
      color: Colors.brown,
    ),
  ),
];
