# simple_widget_snapshot
<img src="https://raw.githubusercontent.com/JhonaCodes/simple_widget_snapshot/main/assets/simple_widget_snapshot.png" width="300" height="150" />

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Nombre del paquete](https://img.shields.io/pub/v/simple_widget_snapshot.svg)](https://pub.dev/packages/simple_widget_snapshot) [![Dart 3](https://img.shields.io/badge/Dart-3%2B-blue.svg)](https://dart.dev/) [![Flutter 3.10](https://img.shields.io/badge/Flutter-3%2B-blue.svg)](https://flutter.dev/)


## Features
Capture snapshots of your widgets and convert them into images or PDF files with ease using our library. Featuring advanced customization options, intuitive APIs, and seamless integration with popular Flutter packages, our library empowers you to take full control over your snapshot generation process.

## Installation
To install simple_build_context, add the following dependency to your pubspec.yaml file:

## Flutter install:
```dart
flutter pub add simple_widget_snapshot
```
## This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):
````flutter
dependencies:
  simple_widget_snapshot: ^2.0.0
````

## Use

# WidgetSnapshot Usage Guide

The `WidgetSnapshot` class provides a simple way to capture a widget as an image.
This guide demonstrates how to use it in your Flutter application.

## Basic Usage

1. Create a `GlobalKey` to identify the widget you want to capture:
```dart
final GlobalKey _globalKey = GlobalKey();
```

2. Wrap the widget you want to capture with a `RepaintBoundary` and assign the `GlobalKey`:
```dart
    RepaintBoundary(
      key: _globalKey, 
      child: YourWidget(),
    )
```

 3. Call the `WidgetSnapshot.capture()` method to capture the widget:
```dart
    WidgetSnapshot.capture(_globalKey, pixelRatio: 3.0).then((result) {
      // Use the captured image data
      setState(() {
        _byteData = result.byteData;
      });
    });
```


## Example
Here's a complete example of how to use `WidgetSnapshot` in a Flutter app:

```dart
class _MyHomePageState extends State<MyHomePage> {
   ByteData? _byteData;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text('WidgetSnapshot Demo')),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             RepaintBoundary(
               key: _globalKey,
               child: Container(
                 height: 200,
                 width: 200,
                 color: Colors.blue,
                 child: Center(child: Text('Capture me!')),
               ),
             ),
             SizedBox(height: 20),
             ElevatedButton(
               onPressed: () {
                 WidgetSnapshot.capture(_globalKey, pixelRatio: 3.0).then((result) {
                   setState(() {
                     _byteData = result.byteData;
                   });
                 });
               },
               child: Text('Capture Widget'),
             ),
             SizedBox(height: 20),
             if (_byteData != null)
               Container(
                 height: 200,
                 width: 200,
                 child: Image.memory(_byteData!.buffer.asUint8List()),
               ),
           ],
         ),
       ),
     );
   }
 }
```

/// This example demonstrates:
1. Setting up a widget to be captured using `RepaintBoundary` and a `GlobalKey`.
2. Capturing the widget when a button is pressed.
3. Displaying the captured image below the original widget.

## Notes
- The `pixelRatio` parameter in `WidgetSnapshot.capture()` affects the quality of the captured image.
  Higher values result in higher quality but larger file sizes.
- Make sure the widget you're capturing is fully rendered before capturing it.
- The captured image is returned as part of a `SnapshotResult` object, which includes
  various representations of the image (ByteData, Uint8List, Image).

<img src="https://raw.githubusercontent.com/JhonaCodes/simple_widget_snapshot/main/assets/step1.png" width="400" height="800" />


<img src="https://raw.githubusercontent.com/JhonaCodes/simple_widget_snapshot/main/assets/step2.png" width="400" height="800" />
