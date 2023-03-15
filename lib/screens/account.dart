import 'package:flutter/material.dart';
import 'package:todo/db/dbHelper.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late DBHelper _dbHelper;

  @override
  void initState(){
    super.initState();
    _dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Text("나의 모든 감사한 나날들",
              style: TextStyle(
                fontFamily: 'NotoSerifKR',
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Colors.black87
              ),
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: FutureBuilder(
              future: _dbHelper.selectAllCount(),
              builder: (context, snapshot) {
                int count = 0;
                if(snapshot.hasData){
                  count = snapshot.data as int;
                  return Text("$count",
                      style: TextStyle(
                          fontFamily: 'NotoSerifKR',
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87
                      )
                  );
                } else {
                  return Text("",
                      style: TextStyle(
                          fontFamily: 'NotoSerifKR',
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87
                      )
                  );
                }
              }
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 200),
              child: Text("지금까지 적은 감사 횟수입니다.", style:TextStyle(color: Colors.black87))
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('모든 기록이 삭제 됩니다.\n진행 하시겠습니까?'),
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
                              child: Text('초기화',
                                  style: TextStyle(
                                      color: Color(0xff689972)
                                  )
                              ),
                              onPressed: () {
                                _dbHelper.deleteAllItem().then((value) {
                                  setState(() {});
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ],
                        );
                      }
                  );
                },
                child: Text("기록\n초기화",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff689972)
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
