import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanheng_app/screens/calendar/page_calendar.dart';
import 'package:wanheng_app/screens/compass/page_main_compass.dart';
import 'package:wanheng_app/screens/profile/page_profile.dart';
import '../utils/app_colors.dart';

// ignore: must_be_immutable
class NavigatorBar extends StatefulWidget {
  NavigatorBar({Key? key, required this.indexPage}) : super(key: key);
  int indexPage;

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selectedIndex = 0;
  final List<Widget> screen = [
    PageCalendar(),
    PageMainCompass(),
    PageProfile(),
  ];
  @override
  void initState() {
    _selectedIndex = widget.indexPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: screen.elementAt(_selectedIndex),
      bottomNavigationBar: ConvexAppBar(
        height: 60,
        top: -20,
        style: TabStyle.reactCircle,
        backgroundColor: Colors.white,
        activeColor: AppColor.mainColor,
        color: AppColor.mainColor,
        items: const [
          TabItem(
            icon: Icon(
              FontAwesomeIcons.calendarMinus,
              color: AppColor.mainColor,
              size: 18,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.calendarMinus,
              color: AppColor.premium,
              size: 28,
            ),
            title: 'ปฏิทิน',
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.solidCompass,
              color: AppColor.mainColor,
              size: 18,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.solidCompass,
              color: AppColor.premium,
              size: 28,
            ),
            title: 'เข็มทิศ',
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.userLarge,
              color: AppColor.mainColor,
              size: 18,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.userLarge,
              color: AppColor.premium,
              size: 28,
            ),
            title: 'บัญชี',
          ),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
