import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/dbHelper.dart';
import 'package:todo/models/gratitude.dart';

class GratitudeScreen extends StatefulWidget {
  const GratitudeScreen({Key? key}) : super(key: key);

  @override
  State<GratitudeScreen> createState() => _GratitudeScreenState();
}

class _GratitudeScreenState extends State<GratitudeScreen> {
  late DBHelper _dbHelper;
  int _today = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _resolutionController = TextEditingController();
  final FocusNode _noteFocus = FocusNode();
  final FocusNode _resolutionFocus = FocusNode();

  @override
  void initState(){
    super.initState();
    _dbHelper = DBHelper();
    _today = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
  }

  @override
  void dispose() {
    _noteController.dispose();
    _resolutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Text(
                      DateFormat('yyyy.MM.dd').format(
                          DateTime.parse('$_today')),
                      style: TextStyle(
                          fontFamily: 'NotoSerifKR',
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 30.0
                      ),
                    ),
                  ),
                  Text("오늘 느낀 감사한 마음을 기록해보세요.",
                      style: TextStyle(
                        color: Colors.black54,
                      )
                  )
                ],
              ),
              FutureBuilder(
                future: _dbHelper.selectItem(_today),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    _noteController.text = snapshot.data?.note as String;
                    _resolutionController.text = snapshot.data?.resolution as String;
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
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
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _noteController,
                          focusNode: _noteFocus,
                          // controller: noteController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 7,
                          maxLength: 200,
                          cursorColor: Colors.brown,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
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
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 50),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _resolutionController,
                          focusNode: _resolutionFocus,
                          keyboardType: TextInputType.multiline,
                          maxLines: 7,
                          maxLength: 200,
                          cursorColor: Colors.brown,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 40.0,
                child: ElevatedButton(
                  onPressed:  () {
                    _noteFocus.unfocus();
                    _resolutionFocus.unfocus();
                    if(_noteController.text.isEmpty && _resolutionController.text.isEmpty){
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('저장할 데이터가 없습니다.'),
                              insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                              actions: [
                                TextButton(
                                  child: Text('확인',
                                      style: TextStyle(
                                          color: Color(0xff689972)
                                      )
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                      );
                    } else {
                      _dbHelper.insertItem(
                          Gratitude(
                              id: int.parse(DateFormat('yyyyMMdd').format(DateTime.now())),
                              note: _noteController.text,
                              resolution: _resolutionController.text
                          )
                      ).then((value) => {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('저장되었습니다.'),
                                insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                                actions: [
                                  TextButton(
                                    child: Text('확인',
                                        style: TextStyle(
                                            color: Color(0xff689972)
                                        )
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                        )
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    // shape: StadiumBorder(),
                    elevation: 0,
                    backgroundColor: Color(0xff689972),
                  ),
                  child: Text('저장'),
                ),
              )
            ]
          ),
        ),
    );
  }
}
