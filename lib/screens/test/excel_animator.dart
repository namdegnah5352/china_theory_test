import 'package:flutter/material.dart';
import 'painter.dart';

class ExcelAnimator extends StatefulWidget {
  const ExcelAnimator({super.key});

  @override
  _ExcelAnimatorState createState() => _ExcelAnimatorState();
}

class _ExcelAnimatorState extends State<ExcelAnimator> with SingleTickerProviderStateMixin {
  double _heightFraction = 0.0;

  late Animation<double> heightAnimation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    heightAnimation = Tween(begin: 0.00, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _heightFraction = heightAnimation.value;
        });
      });
    controller.forward();
    super.initState();
    //controller.dispose();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Painter(_heightFraction),
    );
  }
}
