import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';

class EmotionScreen extends StatelessWidget {
  const EmotionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("감정 선택 페이지")
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Flexible(
                  child: Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      children:[
                        EmotionIcon(),
                        EmotionIcon(),
                        EmotionIcon(),
                        EmotionIcon(),
                        EmotionIcon(),
                      ]
                  )
              ),
              TextButton(
                onPressed: (){
                  // Navigator.pushNamed(context, '/home');
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                    return HomeScreen();
                  }), (r){
                    return false;
                  });
                },
                child: Text("다음")
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmotionIcon extends StatelessWidget {
  const EmotionIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      color: Colors.blue,
      margin: EdgeInsets.all(20)
    );
  }
}

