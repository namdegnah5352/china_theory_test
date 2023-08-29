import 'package:flutter/material.dart';
import 'message_clipper.dart';


class ClipDemo extends StatelessWidget {
   const ClipDemo({
    this.messageColor =  Colors.red,
    this.boxWidth = 250,
    this.boxHeight = 200,
    this.topGap = 0,
    this.leftGap = 0,
    this.topRatio = 0.66,
    this.message = '',
    this.style = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
    this.outerRadius = 20,
    this.borderRadius = 3,
    Key? key
  }) : super(key: key);

  final Color messageColor;
  final double boxWidth;
  final double boxHeight;
  final double topGap;
  final double leftGap;
  final double topRatio;
  final String message;
  final TextStyle style;
  final double outerRadius;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    Size size = textSize(message, style);
    double leftMargin = (boxWidth - size.width)/2;
    return SizedBox(
      width: boxWidth,
      height: boxHeight,
      child: Stack(
        children: [
          Positioned(
            top: topGap,
            left: leftGap,
            child: ClipPath(
              clipper: MessageClipper(borderRadius: borderRadius, outerRadius: outerRadius, topRatio: topRatio,),
              child: Container(
                width: boxWidth,
                height: boxHeight,
                color: messageColor,
              ),    
            ),
          ),
          Positioned(
            top: topGap + (boxHeight - size.height) * (1 - topRatio),
            left: leftGap + leftMargin,
            child: Text(message, style: style,)
          ),
        ],
      ),
    );
  }
}
