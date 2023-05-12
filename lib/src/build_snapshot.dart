import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BuildSnapShot{

  static void build({required RenderRepaintBoundary repaintBoundary, required Widget child}){

    BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
    RenderObjectToWidgetElement rootElement = RenderObjectToWidgetAdapter(
      container: repaintBoundary,
      child: child,
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

  }
}