import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '我是文本组件',
      style: TextStyle(
          color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.bold),
    );
  }
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    Image.asset(name);
//    Image.file(file);
//    Image.memory(bytes);
//    Image.network(src);
    return Image.network(
      'https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png',
      width: 200,
      height: 200,
    );
  }
}

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flatButton = FlatButton(
      onPressed: () => print('按钮被点击'),
      child: Text('FlatButton'),
    );

    RaisedButton(
      onPressed: () => print('按钮被点击'),
      child: Text('RaisedButton'),
    );

    return flatButton;
  }
}

class TextFieldWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextFieldState();
  }
}

class _TextFieldState extends State<TextFieldWidget> {
  var editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextField(
          controller: editController,
        )),
        RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: Text(editController.text),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('确定'))
                    ],
                  );
                });
          },
          child: Text('点击'),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 手动调用 controller 的 dispose 方法以释放资源
    editController.dispose();
  }
}

class ContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('text'),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(4.0),
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
    );
  }
}

class PaddingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('text'),
    );
  }
}

class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('text1'),
        Text('text2'),
        Text('text3'),
        Text('text4'),
      ],
    );
  }
}

class ColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('text1'),
        Text('text2'),
        Text('text3'),
        Text('text4'),
      ],
    );
  }
}

class ExpandWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpandState();
  }
}

class _ExpandState extends State<ExpandWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: RaisedButton(
            child: Text('按钮'),
          ),
        ),
        Expanded(
            flex: 1,
            child: RaisedButton(
              child: Text('按钮2'),
            ))
      ],
    );
  }
}

class StackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(-0.5, -0.5),
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
        Text('barfoo'),
      ],
    );
  }
}
