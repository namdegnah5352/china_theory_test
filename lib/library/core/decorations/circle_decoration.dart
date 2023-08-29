import 'package:flutter/material.dart';
import '../../../config/text_styles.dart';
class CircleDecoration extends Decoration {
  const CircleDecoration({
    required this.backgroundColor,
    required this.dotColor,
    required this.dotDiameter,
    required this.gapLength,
    required this.gapColor,
    this.lineWeight,
});

  final Color backgroundColor;
  final Color dotColor;
  final double dotDiameter;
  final double gapLength;
  final Color gapColor;
  final double? lineWeight;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CircleDecorationPainter(backgroundColor, dotColor, dotDiameter, gapLength, gapColor, lineWeight);
  }
} 
class CircleDecorationPainter extends BoxPainter {
  CircleDecorationPainter(this._background, this._dotColor, this._dotDiameter, this._gapLength, this._gapColor, this.lineWeight);

  final Color _background;
  final Color _dotColor;
  final double _dotDiameter;
  final double _gapLength;
  final Color _gapColor;
  final double? lineWeight;

  late double radius;
  Size textSize(String text, TextStyle style){
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
      return textPainter.size;
  }
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final Rect bounds = offset & configuration.size!;
    Paint background = Paint()..color = _background;
    RRect rrect = RRect.fromRectAndRadius(bounds, Radius.zero);
    canvas.drawRRect(rrect, background);

    final double circleDiameter = 120;
    final Offset circleOffset = Offset(bounds.left + circleDiameter/2, bounds.top + circleDiameter/2);
    Rect circleBox = Rect.fromCenter(center: circleOffset, width: circleDiameter, height: circleDiameter);    
    Path path = Path();
    path.moveTo(circleOffset.dx, circleOffset.dy);
    path.addOval(circleBox);
    canvas.drawPath(path, paint);
    TextPainter tp = TextPainter();
    TextSpan zero;
    String toPlot = 'ABC';
    Size size = textSize(toPlot, bodyBlueFilterStyle);
    zero = TextSpan(text: toPlot, style: bodyBlueFilterStyle);
    tp.text = zero;
    tp.textDirection = TextDirection.ltr;
    tp.layout(minWidth: size.width, maxWidth: size.width);
    tp.paint(canvas, Offset(circleOffset.dx - size.width/2, circleOffset.dy - size.height/2));
    // int xWidth = ((bounds.width - _dotDiameter)/(_dotDiameter + _gapLength)).floor();
    // double mWidth = (bounds.width - (xWidth + 1) * _dotDiameter)/xWidth;
    // int xHeight = ((bounds.height - _dotDiameter)/(_dotDiameter + _gapLength)).floor();
    // double mHeight = (bounds.height - (xHeight + 1) * _dotDiameter)/xHeight;
    // double lineThikness = lineWeight ?? 2;
    // _drawDecoration(canvas, bounds, mWidth, mHeight, xWidth, xHeight, lineThikness);   
  }
  void _drawDecoration(
    Canvas canvas, 
    Rect bounds, 
    double mWidth, 
    double mHeight, 
    int xWidth, 
    int xHeight, 
    double lineThickness
  ) {
    radius = _dotDiameter/2;
    Paint dotPaint = Paint()
      ..color = _dotColor
      ..strokeWidth = _dotDiameter/4
      ..style = PaintingStyle.fill;
    Paint gapPaint = Paint()
      ..color = _gapColor
      ..strokeWidth = lineThickness
      ..style = PaintingStyle.stroke;

    Paint background = Paint()..color = _background;
    RRect rrect = RRect.fromRectAndRadius(bounds, Radius.zero);
    canvas.drawRRect(rrect, background);    
    Path path = Path();
    _addPaths(bounds, path, canvas, dotPaint, gapPaint, mWidth, mHeight, xWidth, xHeight);
  }
  void _addPaths(
      Rect bounds, 
      Path path, 
      Canvas canvas, 
      Paint dotPaint, 
      Paint gapPaint, 
      double mWidth, 
      double mHeight,
      int xWidth,
      int xHeight
    ){
    void drawVerticalSide(Offset offset, bool left){
      Offset currentPosition;
      left 
      ? currentPosition = Offset(offset.dx + radius, offset.dy + radius)
      : currentPosition = Offset(offset.dx - radius, offset.dy + radius);
      for(int i = 0; i < xHeight; i++){
        drawDot(path, currentPosition, dotPaint, canvas);
        currentPosition = Offset(currentPosition.dx, currentPosition.dy + radius);
        drawVerticalLine(path, currentPosition, gapPaint, canvas, mHeight);
        currentPosition = Offset(currentPosition.dx, currentPosition.dy + mHeight + radius);      
      }
      drawDot(path, currentPosition, dotPaint, canvas);    
    }  
    void drawHorizontalSide(Offset offset){
      Offset currentPosition = offset; 
      for(int i = 0; i < xWidth - 1; i++){
        drawHorizontallLine(path, currentPosition, gapPaint, canvas, mWidth);
        currentPosition = Offset(currentPosition.dx + mWidth + radius, currentPosition.dy);
        drawDot(path, currentPosition, dotPaint, canvas);
        currentPosition = Offset(currentPosition.dx + radius, currentPosition.dy);  
      }
      drawHorizontallLine(path, currentPosition, gapPaint, canvas, mWidth);
    }  
    Offset topLeft = Offset(bounds.left, bounds.top);
    drawVerticalSide(topLeft, true);
    Offset topRight = Offset(bounds.right, bounds.top);
    drawVerticalSide(topRight, false);
    Offset bottomLeft = Offset(bounds.left + _dotDiameter, bounds.bottom - radius);
    drawHorizontalSide(bottomLeft);
    topLeft = Offset(bounds.left + _dotDiameter, bounds.top + radius);
    drawHorizontalSide(topLeft);
  }
  void drawDot(Path path, Offset currentPosition, Paint dotPaint, Canvas canvas){
    Rect circleBox = Rect.fromCenter(center: currentPosition, width: _dotDiameter, height: _dotDiameter);
    path.reset();
    path.moveTo(currentPosition.dx, currentPosition.dy);
    path.addOval(circleBox);
    canvas.drawPath(path, dotPaint);   
  }
  void drawVerticalLine(Path path, Offset currentPosition, Paint gapPaint, Canvas canvas, double length){
    path.reset();
    path.moveTo(currentPosition.dx, currentPosition.dy);
    path.lineTo(currentPosition.dx, currentPosition.dy + length);
    canvas.drawPath(path, gapPaint);   
  }
  void drawHorizontallLine(Path path, Offset currentPosition, Paint gapPaint, Canvas canvas, double length){
    path.reset();
    path.moveTo(currentPosition.dx, currentPosition.dy);
    path.lineTo(currentPosition.dx + length, currentPosition.dy );
    canvas.drawPath(path, gapPaint);   
  }  
}

extension on Path {
  void addRotatedRect(Rect bounds) {
    moveTo(bounds.left, bounds.center.dy);
    lineTo(bounds.center.dx, bounds.top);
    lineTo(bounds.right, bounds.center.dy);
    lineTo(bounds.center.dx, bounds.bottom);
    close();
  }
}
