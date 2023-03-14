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
  late DBHelper dbHelper;

  Map<DateTime, List<Event>> events = {};
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDate = DateTime.now();

  String comment = '';
  void setComment(){
    int today = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    int selectedDay = int.parse(DateFormat('yyyyMMdd').format(selectedDate));
    if(today == selectedDay){
      comment = "오늘의 감사를 기록해보세요.";
    } else if(today < selectedDay){
      comment = "앞으로 다가올 날들을 감사함으로 채워보세요.";
    } else {
      comment =  "지나간 아픔과 상실 슬픔 고통은 잊으세요. ";
    }
  }

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    setState(() {
      dbHelper.selectAllIds().then((resultList) {
        for (var element in resultList) {
          int id = element;
          events[DateTime.parse('$id')] = [Event('id')];
        }
      });
      setComment();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: TableCalendar(
              locale: 'ko_KR',
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: focusedDate,
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                setState((){
                  selectedDate = selectedDay;
                  focusedDate = focusedDay;
                  setComment();
                });
              },
              selectedDayPredicate: (DateTime day) {
                return isSameDay(selectedDate, day);
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextFormatter: (date, locale) => DateFormat('yyyy.MM.dd').format(date),
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'NotoSerifKR',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
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
                DateTime markerKey = DateTime(date.year, date.month, date.day);
                if (events.containsKey(markerKey)) {
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
                  FutureBuilder(
                    future: dbHelper.selectItem(int.parse(DateFormat('yyyyMMdd').format(selectedDate))),
                    builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasData) {
                          int id = snapshot.data?.id as int;
                          String note = snapshot.data?.note as String;
                          String resolution = snapshot.data?.resolution as String;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Text("감사한 마음",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'NotoSerifKR',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                )
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(note)
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text("나의 다짐",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'NotoSerifKR',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                )
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 50),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(resolution)
                              ),
                              TextButton(
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text('기록을 삭제하시겠습니까?'),
                                        insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                                        actions: [
                                          TextButton(
                                            child: Text('취소',
                                                style: TextStyle(
                                                    color: Color(0xff689972)
                                                )
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('삭제',
                                                style: TextStyle(
                                                    color: Color(0xff689972)
                                                )
                                            ),
                                            onPressed: () {
                                              dbHelper.deleteItem(id);
                                              setState(() {
                                                events.remove(DateTime.parse('$id'));
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                child: Text("삭제",
                                  style: TextStyle(
                                      color: Color(0xff689972)
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(comment)
                          );
                        }
                      } else {
                        return Text('');
                      }
                    }
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

