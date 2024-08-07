import 'package:flutter/material.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

/// Main class for call functions [capture] and [repaint]
class WidgetSnapShot {
  /// Capture image, use the coming widget for repaint and transform to [ByteData]
  static Future<ByteData?> capture( BuildContext context, { required Widget child, double pixelRatio = 3.0, BoxFit fit = BoxFit.scaleDown, TextDirection textDirection = TextDirection.ltr, GlobalKey? customGlobalKey,
  }) async {
    final GlobalKey repaintBoundaryKey = GlobalKey();
    final OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return RepaintBoundary(
        key: customGlobalKey ?? repaintBoundaryKey,
        child: Directionality(
          textDirection: textDirection,
          child: FittedBox(
            fit: fit,
            child: child,
          ),
        ),
      );
    });


    await Future.delayed(const Duration(milliseconds: 20));

    final RenderRepaintBoundary? boundary = repaintBoundaryKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      overlayEntry.remove();
      return null;
    }

    final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    overlayEntry.remove();

    return byteData;
  }

  /// This is the same [capture] but use only [key] for identificate widget and transform to [ByteData]
  static Future<ByteData> repaint(GlobalKey key,
      {double pixelRatio = 1.0, Duration? duration}) {
    return Future.delayed(duration ?? const Duration(milliseconds: 20),
        () async {
      RenderRepaintBoundary repaintBoundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;

      ui.Image image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData!;
    });
  }
}
