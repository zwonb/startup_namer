import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '动画',
      home: Scaffold(
        appBar: AppBar(
          title: Text('动画'),
        ),
        body: AnimWidget(),
      ),
    );
  }
}

class AnimWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimWidgetState();
  }
}

class _AnimWidgetState extends State<AnimWidget>
    with SingleTickerProviderStateMixin {
  //  AnimationController 的输出是线性的。
  // 非线性的效果可以使用 CurveAnimation
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        // 提供 vsync 最简单的方式，就是直接继承 SingleTickerProviderStateMixin
        vsync: this,
        duration: Duration(milliseconds: 5000));
    // 开始动画
    controller.forward();

    curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: curve,
      child: FlutterLogo(
        size: 200,
      ),
    );

    // 多个动画
//      var scaled = ScaleTransition(
//        child: FlutterLogo(size: 200.0),
//        scale: curve,
//      );
//      return FadeTransition(
//        child: scaled,
//        opacity: curve,
//      );
  }
}
