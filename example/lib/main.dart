import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File result;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    final imageName = 'img1_with_exif.jpg';
    var fileBytes = await rootBundle.load('assets' + '/' + imageName);
    final tempPath = await getTemporaryDirectory();
    final filePath = tempPath.path + '/' + imageName;
    // await writeToFile(
    //   fileBytes,
    //   filePath,
    // );
    // nativeAdd(filePath);
    // final attributesFirst = await Exif.getAttributesIOS(filePath);
    // print(attributesFirst);
    // attributesFirst['Model'] = 'Beakyn';
    // await Exif.setAttributes(filePath, attributesFirst);
    // final attributesSecond = await Exif.getAttributes(filePath);
    // print(attributesFirst);
    // print(attributesSecond);

    final file = await Exif.setAttributesIOS(filePath, {"test": "test2"});
    print('waiting');
    await Future.delayed(Duration(seconds: 5));
    final attrs = await Exif.getAttributesIOS(file.path);
    print(file.path);
    print(attrs);
    // setState(() {
    //   result = file;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: result != null ? Image.file(result) : Container(),
        ),
      ),
    );
  }
}
