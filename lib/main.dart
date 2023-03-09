import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo/screens/calendar.dart';
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
      title: "MyApp",
      home: HomeScreen(),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.brown[800],

        // Define the default font family.
        fontFamily: 'Pretendard',


        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          // displayLarge: TextStyle(fontFamily: 'Pretendard', fontSize: 72.0, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontFamily: 'Pretendard',fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black),
          bodyMedium: TextStyle(fontFamily: 'Pretendard',fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home' : (context) => HomeScreen(),
        '/calendar': (context) => CalendarScreen(),
      },
    );
  }
}

