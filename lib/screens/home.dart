import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/db/dbHelper.dart';
import 'dart:developer';

import 'package:todo/models/gratitude.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DBHelper _dbHelper ;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  void initState(){
    super.initState();
    _dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("캘린더 페이지")
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    TableCalendar(
                      locale: 'ko_KR',
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: focusedDay,
                      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                        // 선택된 날짜의 상태를 갱신합니다.
                        setState((){
                          this.selectedDay = selectedDay;
                          this.focusedDay = focusedDay;
                        });
                      },
                      selectedDayPredicate: (DateTime day) {
                        // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                        return isSameDay(selectedDay, day);
                      },
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.yMMMMd(locale).format(date),
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blue
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(color: Colors.white),
                        todayDecoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text(
                      '감사 일기',
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                        child: FutureBuilder(
                          future: _dbHelper.selectGratitude(int.parse(DateFormat('yyyyMMdd').format(selectedDay))),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              String? note = snapshot.data?.note;
                              return Text('$note');
                            } else {
                              return Text('데이터를 입력하세요');
                            }
                          },
                        )
                    )
                  ]
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/write', arguments: {
                      'id': int.parse(DateFormat('yyyyMMdd').format(selectedDay))
                    });
                  },
                  child: Text("감사일기쓰기")
              ),
            ],
          ),
        ),
      ),
    );
  }
}

