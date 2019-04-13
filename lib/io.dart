import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// async + await
void foo() async {
  const filePath = '''D:\Flutter\Projects\startup_namer\images\pic_test1.png''';
  var file = File(filePath);
  try {
    bool exists = await file.exists();
    if (!exists) {
      await file.create();
    }
  } catch (e) {
    print(e);
  }
}

/// 同步代码 后面带有 Sync
/// 同步版本的 io 方法已经没有太多使用的必要了
/// （Dart 1 不支持 async 函数，所以同步版本的方法的存在是有必要的）
void foo1() {
  const filePath = '''D:\Flutter\Projects\startup_namer\images\pic_test1.png''';
  var file = File(filePath);
  try {
    bool exists = file.existsSync();
    if (!exists) {
      file.createSync();
    }
  } catch (e) {
    print(e);
  }
}

/// 写简单字符串，byte数据
void writeString() async {
  const filePath = '''D:\Flutter\Projects\startup_namer\images\string.txt''';
  var file = File(filePath);
  await file.writeAsString('Hello Dart!');
  List<int> toBeWritten = [1, 2, 3];
  await file.writeAsBytes(toBeWritten);
}

/// 写文件
void writeFile() async {
  const filePath = '''D:\Flutter\Projects\startup_namer\images\string.txt''';
  var file = File(filePath);
  IOSink sink;
  try {
    sink = file.openWrite();
    // 默认的写文件操作会覆盖原有内容；如果要追究内容，用 append 模式
    // sink = file.openWrite(mode: FileMode.append);

    // write() 的参数是一个 Object，他会执行 obj.toString() 把转换后
    // 的 String 写入文件
    sink.write('hello, dart!');
    // 调用 flush 后才会真的把数据写出去
    await sink.flush();
  } catch (e) {
    print(e);
  } finally {
    sink?.close();
  }
}

/// 读简单文件内容
void readString() async {
  const filePath = '''D:\Flutter\Projects\startup_namer\images\string.txt''';
  var file = File(filePath);
  String data = await file.readAsString();
  List<int> list = await file.readAsBytes();
}

/// 读文件内容
void readFile() async {
  const filePath = '''D:\Flutter\Projects\startup_namer\images\string.txt''';
  var file = File(filePath);
  try {
    Stream<List<int>> stream = file.openRead();
    var lines = stream
        // 把内容用 utf-8 解码
        .transform(utf8.decoder)
        // 每次返回一行
        .transform(LineSplitter());
    await for (String line in lines) {
      print(line);
    }
  } catch (e) {
    print(e);
  }
}

class Point {
  int x;
  int y;
  String description;

  Point(this.x, this.y, this.description);

  Point.fromJson(Map<String, dynamic> map)
      : x = map['x'],
        y = map['y'],
        description = map['des'];

  // 注意，我们的方法只有一个语句，这个语句定义了一个 map。
  // 使用这种语法的时候，Dart 会自动把这个 map 当做方法的返回值
  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'des': description};

  @override
  String toString() {
    return 'Point{x: $x, y: $y, description: $description}';
  }
}

void main() {
  final point = Point(2, 12, 'Some point');
  var pointJson = json.encode(point);
  print(pointJson);

  var list = [point, point];
  var pointsJson = json.encode(list);
  print(pointsJson);

  dynamic decode = json.decode(pointJson);
  print(decode.runtimeType);
  // HashMap<String, dynamic>
  var point2 = Point.fromJson(decode);
  print(point2);

  decode = json.decode(pointsJson);
  print(decode.runtimeType);
  // List<dynamic>
  var points2 = <Point>[];
  for (var map in decode) {
    points2.add(Point.fromJson(map));
  }
  print(points2);

  print(request());
}

Future<String> request() async {
  try {
    final response = await http.get('https://www.baidu.com/');
    if (response.statusCode == 200) {
      return response.body;
    }
  } catch (e) {
    print(e);
  }
  return null;
}
