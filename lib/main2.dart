import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 标题
    final titleSection = _TitleSection(
        'Oeschinen Lake Campground', 'Kandersteg, Switzerland', 41);
    // 按钮
    final buttonSection = Container(
      child: Row(
        // 沿水平方向平均放置
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(context, Icons.call, 'Call'),
          _buildButtonColumn(context, Icons.near_me, 'Route'),
          _buildButtonColumn(context, Icons.share, 'Share')
        ],
      ),
    );
    // 底部文本
    final textSection = Container(padding: EdgeInsets.all(32), child: Text('''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
          ''', softWrap: true));

    return MaterialApp(
        title: 'Flutter UI Basic',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Top Lakes'),
          ),
          body: ListView(
            children: <Widget>[
              Image.asset('images/pic_test.png',
                  width: 600, height: 240, fit: BoxFit.cover),
              titleSection,
              buttonSection,
              textSection
            ],
          ),
        ));
  }
}

class _TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final int startCount;

  _TitleSection(this.title, this.subtitle, this.startCount);

  @override
  Widget build(BuildContext context) {
    // 为了给 title section 加上 padding，这里我们给内容套一个 Container
    return Container(
      // 设置上下左右的 padding 都是 32。类似的还有 EdgeInsets.only/symmetric 等
      padding: EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          // 这里为了让标题占满屏幕宽度的剩余空间，用 Expanded 把标题包了起来
          Expanded(
              // 再次提醒读者，Expanded 只能包含一个子元素，使用的参数名是 child。接下来，
              // 为了在竖直方向放两个标题，加入一个 Column。
              child: Column(
            // Column 是竖直方向的，cross 为交叉的意思，也就是说，这里设置的是水平方向
            // 的对齐。在水平方向，我们让文本对齐到 start（读者可以修改为 end 看看效果）
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 跟前面一样，只是为了设置一个 padding
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              )
            ],
          )),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
          Text(startCount.toString())
        ],
      ),
    );
  }
}

Widget _buildButtonColumn(BuildContext context, IconData icon, String label) {
  final color = Theme.of(context).primaryColor;
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(icon, color: color),
      Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: color)))
    ],
  );
}
