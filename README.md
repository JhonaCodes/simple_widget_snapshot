# simple_widget_snapshot
<img src="https://raw.githubusercontent.com/JhonaCodes/simple_build_context/main/assets/simple_widget_snapshot.png" width="300" height="150" />

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Nombre del paquete](https://img.shields.io/pub/v/simple_widget_snapshot.svg)](https://pub.dev/packages/simple_widget_snapshot) [![Dart 3](https://img.shields.io/badge/Dart-3%2B-blue.svg)](https://dart.dev/) [![Flutter 3.10](https://img.shields.io/badge/Flutter-3%2B-blue.svg)](https://flutter.dev/)


## Features
Capture snapshots of your widgets and convert them into images or PDF files with ease using our library. Featuring advanced customization options, intuitive APIs, and seamless integration with popular Flutter packages, our library empowers you to take full control over your snapshot generation process.

## Installation
To install simple_build_context, add the following dependency to your pubspec.yaml file:

````flutter
dependencies:
  simple_widget_snapshot: ^1.0.1
````

Then run  ```flutter pub get``` on the command line


## Use
```flutter
import 'package:simple_build_context/src/simple_widget_snapshot.dart';
```

```dart

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ByteData? _byteData;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:  Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RepaintBoundary( /// Used for paint icon
              key: _globalKey, /// necesary for identificate the icon to reapint
              child: Container(
                height: 200,
                width: 200,
                margin: const EdgeInsets.all(0),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.red,
                        width: 2
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      child: Container(
                        width: double.infinity,
                        color: Colors.green,
                        child: const Center(child: Text('Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),)),
                      ),
                    ),

                    const Text(' Factura: 98234y49837gh'),
                    const Text(' Name: JhonaCode'),
                    const Text(' Price: \$ 1.200'),
                    const Spacer(),
                    const Text(' DONE', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900))
                  ],
                ),
              ),
            ),

            const Text("TAKE PHOTO ICON"),
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
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: ()=> _repaintSnapShot(_globalKey),
            tooltip: 'Repaint SnapShot',
            child: const Icon(Icons.cached),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: _captureSnapShot,
            tooltip: 'Capture SnapShot',
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _repaintSnapShot(GlobalKey<State<StatefulWidget>> gKey) async {
    ByteData byteData = await WidgetSnapShot.repaint(gKey);
    setState(() => _byteData = byteData);
  }

  _captureSnapShot() async {
    ByteData byteData = await WidgetSnapShot.capture(child:Container(
      width: 300,
      height: 400,
      color: Colors.blue,
    ));
    setState(() => _byteData = byteData);
  }

}

```

<img src="https://raw.githubusercontent.com/JhonaCodes/simple_build_context/main/assets/step1.png.png" width="600" height="400" />


<img src="https://raw.githubusercontent.com/JhonaCodes/simple_build_context/main/assets/step2.png.png" width="600" height="400" />
