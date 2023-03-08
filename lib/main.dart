import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo/screens/emotion.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/write.dart';

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
      initialRoute: '/home',
      routes: {
        '/home' : (context) => HomeScreen(),
        '/write': (context) => WriteScreen(),
        '/emotion' : (context) => EmotionScreen()
      },
    );
  }
}

