import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo/screens/home.dart';

void main() async{
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TodayThanks",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Pretendard',
      ),
    );
  }
}

