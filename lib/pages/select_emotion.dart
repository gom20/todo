import 'package:flutter/material.dart';

class SelectEmotionPage extends StatelessWidget {
  const SelectEmotionPage({Key? key}) : super(key: key);

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
                  Navigator.pushNamed(context, '/select_gratitude');
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

