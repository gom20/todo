import 'dart:async';
import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Pretendard',
        // textTheme: const TextTheme(
        //   titleLarge: TextStyle(fontFamily: 'Pretendard',fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black),
        //   bodyMedium: TextStyle(fontFamily: 'Pretendard',fontSize: 14.0, fontWeight: FontWeight.w700),
        // ),
      ),
      initialRoute: '/home',
      routes: {
        '/splash' : (context) => SplashScreen(),
        '/home' : (context) => HomeScreen(),
        '/calendar': (context) => CalendarScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => HomeScreen()
            )
        )
    );
  }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
            width: double.infinity,
            color: Color(0xff689972),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:EdgeInsets.fromLTRB(0, 0, 0, 2),
                  child: Text(
                    "오늘도 감사",
                    style: TextStyle(
                      color: Color(0xffFFF1DE),
                      fontFamily: "NotoSerifKR",
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  margin:EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    "Gratitude Journal",
                    style: TextStyle(
                        color: Color(0xffFFF1DE),
                        fontWeight: FontWeight.w200,
                        fontFamily: 'NotoSerifKR',
                        fontSize: 15
                    ),
                  ),
                )
              ],
            )
        ),
      );
    }
}
