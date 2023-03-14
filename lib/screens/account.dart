import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/dbHelper.dart';
import 'package:todo/models/gratitude.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text("총 감사 횟수")
          ),
          Container(
              child: Text("데이터 내보내기")
          ),
          Container(
              child: Text("데이터 일괄삭제")
          ),
        ],
      )
    );
  }
}
