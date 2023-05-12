import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'package:simple_widget_snapshot/simple_widget_snapshot.dart';

void main(){

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Simple_widget_snapshot',
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ByteData? _byteData;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _repaintSnapShot,
                  child: const Text('Repaint SnapShot'),
                ),
                ElevatedButton(
                  onPressed: _captureSnapShot,
                  child: const Text('Capture SnapShot'),
                ),
                _byteData != null ? Container(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Image.memory(
                      _byteData!.buffer.asUint8List()
                  ),
                ) : Container()
              ],
            ),
          )
      ),
    );
  }

  _repaintSnapShot() async {
    ByteData byteData = await WidgetSnapShot.repaint(_globalKey);
    setState(() => _byteData = byteData);
  }

  _captureSnapShot() async {
    ByteData byteData = await WidgetSnapShot.capture(child:Container(
      width: 200,
      height: 400,
      color: Colors.blue,
    ));
    setState(() => _byteData = byteData);
  }

}