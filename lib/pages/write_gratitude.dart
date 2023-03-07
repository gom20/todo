import 'package:flutter/material.dart';

class WriteGratitudePage extends StatelessWidget {
  const WriteGratitudePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    CustomInput(),
                    CustomInput(),
                    CustomInput(),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/select_emotion');
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

class CustomInput extends StatelessWidget {
  const CustomInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Input',
        ),
      ),
    );
  }
}
