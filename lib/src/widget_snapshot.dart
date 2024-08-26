import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

/// A utility class for capturing widget snapshots and converting them to various image formats.
class WidgetSnapshot {

  static ByteData? _byteData;
  static Uint8List? _uint8list;
  static int? _bytes;
  static Image? _imageMemory;


  /// Captures a widget as a ui.Image.
  ///
  /// This private method handles the core functionality of capturing the widget.
  ///
  /// Parameters:
  /// - key: GlobalKey of the widget to capture.
  /// - pixelRatio: The pixel ratio for the image capture.
  /// - delay: Duration to wait before capturing, allowing widget to fully render.
  ///
  /// Returns a Future<ui.Image?> representing the captured image.
  static Future<ui.Image?> _captureWidget( GlobalKey key, { required double pixelRatio, required Duration delay, }) async {

    try {

      // Wait a bit to ensure the widget is fully rendered
      await Future.delayed(delay);

      // Getting the RenderRepaintBoundary
      RenderRepaintBoundary? boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Could not find RenderRepaintBoundary');
      }

      // Capture the image
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

      return image;

    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      return null;
    }

  }


  /// Captures a widget and returns various representations of the captured image.
  ///
  /// Parameters:
  /// - key: GlobalKey of the widget to capture.
  /// - pixelRatio: The pixel ratio for the image capture (default: 1.0).
  /// - delay: Duration to wait before capturing (default: 20 milliseconds).
  ///
  /// Returns a Future<SnapshotResult> containing different image representations.
  static Future<SnapshotResult> capture( GlobalKey key, { double pixelRatio = 1.0,  Duration delay = const Duration(milliseconds: 20), }) async {
    ui.Image? image = await _captureWidget(key, pixelRatio: pixelRatio, delay: delay);

    if (image != null) {

      _byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      _uint8list = _byteData?.buffer.asUint8List();
      _bytes = _byteData?.buffer.lengthInBytes;
      _imageMemory = _uint8list != null ? Image.memory(_uint8list!) : null;

      if(_byteData == null){
        log('Could not convert image to bytes');
      }else{
        var formatter = NumberFormat('#,##0.00');
        log('Image generated successfully: ${formatter.format(_bytes)} bytes');
      }

    } else {
      log('Could not capture image');
    }

    return SnapshotResult(
        byteData: _byteData,
        uint8list: _uint8list,
        imageFromMemory: _imageMemory,
        bytesImage: _bytes
    );
  }

}

/// A class to hold various representations of the captured image.
class SnapshotResult{
  final ByteData? byteData;
  final Uint8List? uint8list;
  final int? bytesImage;
  final Image? imageFromMemory;
  SnapshotResult({this.byteData, this.uint8list, this.imageFromMemory, this.bytesImage});
}