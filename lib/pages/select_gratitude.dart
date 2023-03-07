import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectGratitudePage extends StatelessWidget {
  const SelectGratitudePage({Key? key}) : super(key: key);

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
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/write_gratitude');
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
