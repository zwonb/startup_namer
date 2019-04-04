import 'dart:math';

import 'package:flutter/material.dart';
import 'package:startup_namer/MyWidget.dart';

void main() {
  // 创建一个 MyApp
  runApp(MyApp());
}

/// 这个 widget 作用这个应用的顶层 widget.
/// 这个 widget 是无状态的，所以我们继承的是 [StatelessWidget].
/// 对应的，有状态的 widget 可以继承 [StatefulWidget]
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // 移动设备使用这个 title 来表示我们的应用。具体一点说，在 Android 设备里，我们点击
        // recent 按钮打开最近应用列表的时候，显示的就是这个 title。
        // 应用的名称
        title: 'My First Flutter App',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Flutter Rolling Demo'),
            ),
            body: Center(
              child: StackWidget(),
            )));
  }
}

class RollingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RollingState();
  }
}

class _RollingState extends State<RollingButton> {
  final _random = Random();

  List<int> _roll() {
    final roll1 = _random.nextInt(6) + 1;
    final roll2 = _random.nextInt(6) + 1;
    return [roll1, roll2];
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onPressed,
      child: Text('Roll'),
    );
  }

  void _onPressed() {
    debugPrint('_onPressed');
    final rollResults = _roll();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              content:
                  Text('Roll Result:(${rollResults[0]}, ${rollResults[1]})'));
        });
  }
}
