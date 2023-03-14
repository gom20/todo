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

  @override
  Widget build(BuildContext context) {
    int today = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

    final noteController = TextEditingController();
    final resolutionController = TextEditingController();
    final noteFocus = FocusNode();
    final resolutionFocus = FocusNode();

    String latestSavedData = '';
    DBHelper dbHelper = DBHelper();
    dbHelper.selectItem(today);

    @override
    void dispose() {
      noteController.dispose();
      resolutionController.dispose();
      super.dispose();
    }

    return SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(25),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                          DateFormat('yyyy.MM.dd').format(
                              DateTime.parse('$today')),
                          style: TextStyle(
                              fontFamily: 'NotoSerifKR',
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 30.0
                          ),
                        ),
                      ),
                      Text("오늘, 감사한 마음을 기록해보세요.",
                          style: TextStyle(
                            color: Colors.black54,
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: dbHelper.selectItem(today),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        noteController.text = snapshot.data?.note as String;
                        resolutionController.text = snapshot.data?.resolution as String;
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Text("오늘의 감사함",
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
                            child: TextFormField(
                              focusNode: noteFocus,
                              controller: noteController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              cursorColor: Colors.brown,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white10
                                ),
                                hintText: '오늘도 감사한 하루였나요?',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: Text("오늘의 다짐",
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
                            child: TextFormField(
                              focusNode: resolutionFocus,
                              controller: resolutionController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              cursorColor: Colors.brown,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white10
                                ),
                                hintText: '오늘도 감사한 하루였나요?',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ),
                SizedBox(
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed:  () {
                          noteFocus.unfocus();
                          resolutionFocus.unfocus();
                          dbHelper.insertItem(
                            Gratitude(
                                id: int.parse(DateFormat('yyyyMMdd').format(DateTime.now())),
                                note: noteController.text,
                                resolution: resolutionController.text
                            )
                          ).then((value) => {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('감사한 마음이 저장되었습니다.'),
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
                        },
                        style: ElevatedButton.styleFrom(
                          // shape: StadiumBorder(),
                          elevation: 0,
                          backgroundColor: Color(0xff689972),
                        ),
                        child: Text('저장'),
                      ),
                    )
                ),
              ]
            ),
          ),
        ),
      );
  }
}
