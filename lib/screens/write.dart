import 'package:flutter/material.dart';
import 'package:todo/db/dbHelper.dart';
import 'package:todo/models/gratitude.dart';


class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    print('writeScreen');

    var selectedDay = arguments['id'];

    final textFieldController = TextEditingController();

    @override
    void dispose() {
      textFieldController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
          title: Text("감사함")
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:
          Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Text("오늘의 감사"),
                ),
                Flexible(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textFieldController,
                          decoration: InputDecoration(
                            labelText: 'Input',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: (){
                      DBHelper dbHelper = DBHelper();
                      dbHelper.insertGratitude(Gratitude(id: selectedDay, note: textFieldController.text));
                      Navigator.pushNamed(context, '/emotion');
                    },
                    child: Text("다음"),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
