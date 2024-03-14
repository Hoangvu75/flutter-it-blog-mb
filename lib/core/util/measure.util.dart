import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MeasureUtil {
  MeasureUtil._();

  static Size measureWidget(
    Widget widget, [
    BoxConstraints constraints = const BoxConstraints(),
  ]) {
    var pipelineOwner = PipelineOwner();
    var rootView = pipelineOwner.rootNode = _MeasurementView(constraints);
    var buildOwner = BuildOwner(focusManager: FocusManager());
    var element = RenderObjectToWidgetAdapter<RenderBox>(
      container: rootView,
      debugShortDescription: '[root]',
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: widget,
      ),
    ).attachToRenderTree(buildOwner);
    try {
      rootView.scheduleInitialLayout();
      pipelineOwner.flushLayout();
      return rootView.size;
    } finally {
      element.update(
        RenderObjectToWidgetAdapter<RenderBox>(container: rootView),
      );
      buildOwner.finalizeTree();
    }
  }
}

class _MeasurementView extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  final BoxConstraints boxConstraints;

  _MeasurementView(this.boxConstraints);

  @override
  void performLayout() {
    assert(child != null);
    child!.layout(boxConstraints, parentUsesSize: true);
    size = child!.size;
  }

  @override
  void debugAssertDoesMeetConstraints() => true;
}
