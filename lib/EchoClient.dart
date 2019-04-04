import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo 客户端',
      home: MessageListScreen(),
    );
  }
}

class MessageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessageFormState();
  }
}

class _MessageFormState extends State<MessageForm> {
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          // 我们让输入框占满一行里除按钮外的所有空间
          Expanded(
              child: Container(
            margin: EdgeInsets.only(right: 8),
            child: TextField(
              decoration: InputDecoration(
                  hintText: '输入消息', contentPadding: EdgeInsets.all(0)),
              style: TextStyle(fontSize: 22, color: Colors.black54),
              controller: editController,
              // 自动获取焦点。这样在页面打开时就会自动弹出输入法
              autofocus: true,
            ),
          )),
          InkWell(
            onTap: () {
              debugPrint('发送${editController.text}');
              final msg = Message(
                  editController.text, DateTime.now().millisecondsSinceEpoch);
              Navigator.pop(context, msg);
            },
            onDoubleTap: () => debugPrint('双击了'),
            onLongPress: () => debugPrint('长按了'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(4)),
              child: Text('发送'),
            ),
          )
        ],
      ),
    );
  }

  // 对象被从 widget 树里永久移除的时候调用 dispose 方法（可以理解为对象要销毁了）
  // 这里我们需要主动再调用 editController.dispose() 以释放资源
  @override
  void dispose() {
    super.dispose();
    editController.dispose();
  }
}

class AddMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加消息'),
      ),
      body: MessageForm(),
    );
  }
}

class MessageListScreen extends StatelessWidget {
  final messageListKey =
      GlobalKey<_MessageListState>(debugLabel: 'messageListKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Echo Client')),
      body: MessageList(key: messageListKey),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddMessageScreen()));
            debugPrint(result.toString());
            if (result is Message) {
              messageListKey.currentState.addMessage(result);
            }
          },
          tooltip: 'Add Message',
          child: Icon(Icons.add)),
    );
  }
}

class MessageList extends StatefulWidget {
  MessageList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MessageListState();
  }
}

class _MessageListState extends State<MessageList> {
  final List<Message> message = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var msg = message[index];
        var subtitle = DateTime.fromMillisecondsSinceEpoch(msg.timestamp)
            .toLocal()
            .toIso8601String();
        return ListTile(title: Text(msg.msg), subtitle: Text(subtitle));
      },
      itemCount: message.length,
    );
  }

  void addMessage(Message msg) {
    setState(() {
      message.add(msg);
    });
  }
}

class Message {
  final String msg;
  final int timestamp;

  Message(this.msg, this.timestamp);

  @override
  String toString() {
    return 'Message{msg: $msg, timestamp: $timestamp}';
  }
}
