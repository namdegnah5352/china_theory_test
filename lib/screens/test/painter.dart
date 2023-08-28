import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  late double _heightFraction;
  late Paint _paint;

  Painter(this._heightFraction) {
    _paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
