import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/dbHelper.dart';
import 'package:todo/models/gratitude.dart';
import 'package:todo/screens/calendar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedDay = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

    final arguments = (ModalRoute
        .of(context)
        ?.settings
        .arguments ?? <String, dynamic>{}) as Map;
    final textFieldController = TextEditingController();

    @override
    void dispose() {
      textFieldController.dispose();
      super.dispose();
    }

    return Container(
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
        body: Container(
          color: Colors.transparent,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(25),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            DateFormat.yMMMd().format(
                                DateTime.parse('$selectedDay')),
                            style: TextStyle(
                                fontFamily: 'NotoSerifKR',
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 30.0
                            ),
                          ),
                        ),
                        Text("감사한 마음을 기록해보세요.",
                          style: TextStyle(
                            color: Colors.black54,
                          )
                        )
                      ],
                    ),

                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: Text("오늘의 감사함",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'NotoSerifKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            )
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            cursorColor: Colors.brown,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white10
                              ),
                              hintText: '오늘도 감사한 하루였나요?',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text("오늘의 다짐",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'NotoSerifKR',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            cursorColor: Colors.brown,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white10
                              ),
                              hintText: '오늘도 감사한 하루였나요?',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      child: Container(
                        width: double.infinity,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint('ElevatedButton Clicked');
                          },
                          style: ElevatedButton.styleFrom(
                            // shape: StadiumBorder(),
                            elevation: 0,
                            backgroundColor: Color(0xff689972),
                          ),
                          child: Text('기록 하기'),
                        ),
                      )
                  ),
                ]
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.edit_calendar),
                label: "쓰기"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: '기록',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '설정',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xff689972),
          selectedLabelStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
          ),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
