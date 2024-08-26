import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:simple_widget_snapshot/simple_widget_snapshot.dart';

/// Simple way for use [simple_widget_snapshot]
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Widget Snapshot Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'simple_widget_snapshot'),
    );
  }
}

final GlobalKey _globalKey = GlobalKey();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// First step is declare a private varaible if you prefeer use just for this context
  /// and for this example i'm create a [GlobalKey]
  ByteData? _byteData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: CaptureWidget(
          byteData: _byteData,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async{

              WidgetSnapshot.capture(_globalKey,pixelRatio: 3.0).then((image){
                setState(() {
                  _byteData = image.byteData;
                });
              });


            },
            tooltip: 'Repaint SnapShot',
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}

class CaptureWidget extends StatelessWidget {
  final ByteData? byteData;
  const CaptureWidget({super.key, this.byteData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RepaintBoundary(
          /// Used for paint icon
          key: _globalKey,

          /// necesary for identificate the icon to reapint
          child: Container(
            height: 200,
            width: 200,
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  child: Container(
                    width: double.infinity,
                    color: Colors.green,
                    child: const Center(
                        child: Text(
                          'Account',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        )),
                  ),
                ),
                const Text(' Factura: 98234y49837gh'),
                const Text(' Name: JhonaCode'),
                const Text(' Price: \$ 1.200'),
                const Spacer(),
                const Text(' DONE',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w900))
              ],
            ),
          ),
        ),
        const Text("TAKE PHOTO ICON"),
        byteData != null
            ? Container(
          height: 200,
          decoration:
          BoxDecoration(border: Border.all(color: Colors.black)),
          child: Image.memory(byteData!.buffer.asUint8List()),
        )
            : Container()
      ],
    );
  }
}