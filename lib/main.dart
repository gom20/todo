import 'package:flutter/material.dart';
import 'package:todo/pages/select_emotion.dart';
import 'package:todo/pages/select_gratitude.dart';
import 'package:todo/pages/write_gratitude.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      home: WriteGratitudePage(),
      initialRoute: '/select_gratitude',
      routes: {
        '/write_gratitude': (context) => WriteGratitudePage(),
        '/select_emotion' : (context) => SelectEmotionPage(),
        '/select_gratitude' : (context) => SelectGratitudePage()
      },
    );
  }
}

