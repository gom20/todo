import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/account.dart';
import 'package:todo/screens/calendar.dart';
import 'package:todo/screens/gratitude.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    GratitudeScreen(),
    CalendarScreen(),
    AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffFFF1DE),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg-image.png'),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.edit_calendar),
                    label: "감사하기"
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: '기록보기',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: '설정하기',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color(0xff689972),
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w400,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w400,
              ),
              onTap: _onItemTapped,
            ),
          ),
        ),
      ]
    );
  }
}
