import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

class BuildImageSnapShot{

  ByteData byteData;

  BuildImageSnapShot(this.byteData);

  void save(){
    Uint8List image8List = byteData.buffer.asUint8List();

    _convertToPng(image8List);

  }


  Future<void> _convertToPng(Uint8List imageData) async {
    // Decodifica la imagen desde Uint8List
    ui.Image img = await decodeImageFromList(imageData);

    // Convierte la imagen a ByteData en formato png
    ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    // Convierte ByteData a Uint8List
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Guarda la imagen en disco
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/image.png';
    final File imageFile = File(imagePath);
    await imageFile.writeAsBytes(pngBytes);
  }

}