import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '页面间跳转',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstScreenState();
  }
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个界面'),
      ),
      body: Center(
        child: RaisedButton(
          // 异步接收回调数据
          onPressed: () async {
            var msg = await Navigator.push(
                context, MaterialPageRoute(builder: (_) => SecondScreen()));
            debugPrint(msg);
          },
          child: Text('点击跳转第二个界面'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SecondState();
  }
}

class _SecondState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('第二个界面')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
//            Navigator.pop(context);
            Navigator.pop(context, '可以返回一些数据');
          },
          child: Text('点击退出'),
        ),
      ),
    );
  }
}
