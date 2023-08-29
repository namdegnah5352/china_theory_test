import 'dart:core';
import 'package:flutter/material.dart';

/// [MessageClipper], can be used with [ClipPath] widget, and clips the widget in dialog box shape
class MessageClipper extends CustomClipper<Path> {
  MessageClipper({
    this.borderRadius = 15, 
    required this.outerRadius,
    required this.topRatio,
  });
  final double borderRadius;
  final double outerRadius;
  final double topRatio;

  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height * topRatio;
    double oneThird = width / 3;
    final path = Path();
    path.moveTo(outerRadius, 0);
    path.cubicTo(outerRadius, 0, 0, 0, 0, outerRadius);
    path.lineTo(0, rheight - outerRadius);
    path.cubicTo(0, rheight - outerRadius, 0, rheight, outerRadius, rheight);
    path.lineTo(oneThird, rheight);
    path.lineTo(width / 2 - borderRadius, height - borderRadius);
    path.cubicTo(width / 2 - borderRadius, height - borderRadius, width / 2, height, width / 2 + borderRadius, height - borderRadius);   
    path.lineTo(2 * oneThird, rheight);
    path.lineTo(width - outerRadius, rheight);
    path.cubicTo(width - outerRadius, rheight, width, rheight, width, rheight - outerRadius);  
    // now the top right corner using the outerRadius
    path.lineTo(width, outerRadius);
    path.cubicTo(width, outerRadius, width, 0, width - outerRadius, 0);  
    //path.lineTo(width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
Size textSize(String text, TextStyle style) {
  final TextPainter _textPainter = TextPainter(
      text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return _textPainter.size;
}  
