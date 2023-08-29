import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Edge {top, right, bottom, left}

/// [ArrowClipper] that can be used with [ClipPath] to clip widget in Arrow shape

class ArrowClipper extends CustomClipper<Path> {
  ArrowClipper({
    required this.triangleDepth, 
    required this.rectangleClipLength, 
    required this.edge
  });

  /// The height of the triangle part of arrow in the [edge] direction
  final double triangleDepth;

  /// The height of the rectangle part of arrow that is clipped
  final double rectangleClipLength;

  /// The edge the arrow points
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.top:
        return _getTopPath(size);
      case Edge.right:
        return _getRightPath(size);
      case Edge.bottom:
        return _getBottomPath(size);
      case Edge.left:
        return _getLeftPath(size);
      default:
        return _getRightPath(size);
    }
  }

  Path _getTopPath(Size size) {
    var path = Path();
    path.moveTo(0.0, triangleDepth);
    path.lineTo(rectangleClipLength, triangleDepth);
    path.lineTo(rectangleClipLength, size.height);
    path.lineTo(size.width - rectangleClipLength, size.height);
    path.lineTo(size.width - rectangleClipLength, triangleDepth);
    path.lineTo(size.width, triangleDepth);
    path.lineTo(size.width / 2, 0.0);
    path.close();
    return path;
  }

  Path _getRightPath(Size size) {
    var path = Path();
    path.moveTo(0.0, rectangleClipLength);
    path.lineTo(size.width - triangleDepth, rectangleClipLength);
    path.lineTo(size.width - triangleDepth, 0.0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - triangleDepth, size.height);
    path.lineTo(size.width - triangleDepth, size.height - rectangleClipLength);
    path.lineTo(0.0, size.height - rectangleClipLength);
    path.close();
    return path;
  }

  Path _getBottomPath(Size size) {
    var path = Path();
    path.moveTo(rectangleClipLength, 0.0);
    path.lineTo(rectangleClipLength, size.height - triangleDepth);
    path.lineTo(0.0, size.height - triangleDepth);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - triangleDepth);
    path.lineTo(size.width - rectangleClipLength, size.height - triangleDepth);
    path.lineTo(size.width - rectangleClipLength, 0.0);
    path.close();
    return path;
  }

  Path _getLeftPath(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height / 2);
    path.lineTo(triangleDepth, size.height);
    path.lineTo(triangleDepth, size.height - rectangleClipLength);
    path.lineTo(size.width, size.height - rectangleClipLength);
    path.lineTo(size.width, rectangleClipLength);
    path.lineTo(triangleDepth, rectangleClipLength);
    path.lineTo(triangleDepth, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    ArrowClipper oldie = oldClipper as ArrowClipper;
    return triangleDepth != oldie.triangleDepth ||
        rectangleClipLength != oldie.rectangleClipLength ||
        edge != oldie.edge;
  }
}
