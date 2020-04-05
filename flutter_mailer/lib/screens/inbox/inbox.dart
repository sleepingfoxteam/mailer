import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermailer/screens/archived/archived.dart';
import 'package:fluttermailer/utils/ui/app_ui.dart';

import 'inbox_screen.dart';

DateTime currentBackPressed;

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          children: <Widget>[
            InboxScreen(),
            ArchivedScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentPage,
          onItemSelected: (index) {
            setState(() {
              currentPage = index;
              _pageController.animateToPage(currentPage,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInCirc);
            });
          },
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.inbox),
              title: Text("Inbox"),
              activeColor: Colors.black,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.archive),
              title: Text("Archived"),
              activeColor: Colors.black,
            ),
          ],
        ),
      ),
      onWillPop: () {
        final now = DateTime.now();
        if (currentBackPressed == null ||
            now.difference(currentBackPressed) > Duration(seconds: 2)) {
          AppUIUtils.showToast(title: "Press again to exit");
          currentBackPressed = now;
          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}
