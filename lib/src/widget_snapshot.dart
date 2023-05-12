import 'package:flutter/material.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:simple_widget_snapshot/src/build_snapshot.dart';


class WidgetSnapShot{

  static Future<ByteData> capture( {
    required Widget child,
    Alignment alignment = Alignment.center,
    Size size = const Size(double.maxFinite, double.maxFinite),
    double devicePixelRatio = 1.0,
    double pixelRatio = 1.0
  } ) async {

    RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    RenderView renderingSnapShot = RenderView(
      child: RenderPositionedBox(alignment: alignment, child: repaintBoundary),
      configuration: ViewConfiguration(
        size: size,
        devicePixelRatio: devicePixelRatio,
      ),
      view: WidgetsBinding.instance.platformDispatcher.views.first,
    );


    PipelineOwner pipelineOwner = PipelineOwner();
    pipelineOwner.rootNode = renderingSnapShot;
    renderingSnapShot.prepareInitialFrame();

    BuildSnapShot.build(repaintBoundary: repaintBoundary, child: child);

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    ui.Image image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!;
  }

  static Future<ByteData> repaint(GlobalKey key, {double pixelRatio = 1.0, Duration? duration}) {

    return Future.delayed(duration ?? const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary repaintBoundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;

      ui.Image image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData!;
    });

  }

  /// Next Update
  /*
  static void toImage({String format = 'png'}){

  }

   */
}