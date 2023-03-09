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
  @override
  Widget build(BuildContext context) {
    int selectedDay = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final textFieldController = TextEditingController();

    @override
    void dispose() {
      textFieldController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("오늘도 감사해"),
        titleTextStyle: TextStyle(
          fontFamily: 'Pretendard',
          color: Color(0xffE69E82),
          fontWeight: FontWeight.w500,
          fontSize: 20.0
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:
          Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    DateFormat.yMMMd('ko_KR').format(DateTime.parse('$selectedDay')),
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                      color: Color(0xffE69E82),
                      fontSize: 30.0
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textFieldController,
                          decoration: InputDecoration(
                            labelText: 'Input',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: (){
                      DBHelper dbHelper = DBHelper();
                      dbHelper.insertGratitude(Gratitude(id: int.parse(DateFormat('yyyyMMdd').format(DateTime.now())), note: textFieldController.text));
                      Navigator.pushNamed(context, '/calendar');
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                      //   return CalendarScreen();
                      // }), (r){
                      //   return false;
                      // });
                    },
                    child: Text("다음"),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
