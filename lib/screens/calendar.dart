import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/db/dbHelper.dart';

class Event {
  String title;
  Event(this.title);
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DBHelper _dbHelper ;
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  final noteController = TextEditingController();
  final resolutionController = TextEditingController();
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023,3,11) : [ Event('title') ],
    DateTime.utc(2023,3,13) : [ Event('title3') ],
  };

  @override
  void initState(){
    super.initState();
    _dbHelper = DBHelper();
    _dbHelper.selectAllItems().then((resultList) {
      for (var element in resultList) {
        setState(() {
          events[DateTime.parse('$element.id')] = [Event('test')];
        });
      }});

  }

  @override
  Widget build(BuildContext context) {
    List<Event> _getEventsForDay(DateTime day) {
      return events[day] ?? [];
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text("감사 기록",
              style: TextStyle(
                  fontFamily: 'NotoSerifKR',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 30.0
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TableCalendar(
              locale: 'ko_KR',
              eventLoader: _getEventsForDay,
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
                titleTextFormatter: (date, locale) => DateFormat('yyyy.MM.dd').format(date),
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                    fontSize: 30.0,
                    // color: Color(0xff689972),
                    fontFamily: 'NotoSerifKR',
                    fontWeight: FontWeight.w500
                ),
              ),
              calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
                selectedDecoration: BoxDecoration(
                  color: Color(0xff689972),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Color(0xff689972).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders:
              CalendarBuilders(markerBuilder: (context, date, dynamic event) {
                if (event.isNotEmpty) {
                  return Container(
                    width: 35,
                    decoration: BoxDecoration(
                        color: Color(0xff689972).withOpacity(0.2),
                        shape: BoxShape.circle),
                  );
                }
              }),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                        child: FutureBuilder(
                          future: _dbHelper.selectItem(int.parse(DateFormat('yyyyMMdd').format(selectedDay))),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              String note = snapshot.data?.note as String;
                              String resolution = snapshot.data?.resolution as String;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Text("그날의 감사함",
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
                                    child: Text(note)
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("그날의 다짐",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'NotoSerifKR',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 50),
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(resolution)
                                  ),
                                  TextButton(
                                      onPressed: (){
                                        Navigator.pushNamed(context, '/home', arguments: {
                                          'id': int.parse(DateFormat('yyyyMMdd').format(selectedDay))
                                        });
                                      },
                                      child: Text("삭제 하기")
                                  ),
                                ],
                              );
                            } else {
                              noteController.text = '';
                              return Text('test');
                            }
                          },
                        )
                    ),
                  ]
                ),
              ),
          )


        ],
      ),
    );
  }
}

