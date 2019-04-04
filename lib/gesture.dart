import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '手势处理',
      home: Scaffold(
        appBar: AppBar(title: Text('手势处理')),
        body: ListenerWidget(),
      ),
    );
  }
}

class PressedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: () => debugPrint('点击'), child: Text('点击'));
  }
}

///跟 button 不同，大多数的控件没有手势事件监听函数可以设置，
///为了监听这些控件上的手势事件，我们需要使用另一个控件——GestureDetector
class GestureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text('我是可点击的Text'),
      onTap: () => debugPrint('点击了'),
    );
  }
}

///GestureDetector 在绝大部分时候都能够满足我们的需求，
///如果真的满足不了，我们还可以使用最原始的 Listener 控件
class ListenerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Text('Listener Text'),
      onPointerDown: (e) => debugPrint('onPointerDown'),
      onPointerMove: (e) => debugPrint('onPointerMove'),
      onPointerUp: (e) => debugPrint('onPointerUp'),
      onPointerCancel: (e) => debugPrint('onPointerCancel'),
    );
  }
}
