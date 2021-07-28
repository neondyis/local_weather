import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.strokeWidth = 3;
    paint
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.2, size.height),
        Offset(size.width, size.height),
        [
          Color(0xFFa1c4fd),
          Color(0xFFc2e9fb),
        ],
      );
    paint..isAntiAlias = true;

    var startPoint = Offset(0, size.height);
    var controlPoint1 = Offset(size.width / 2, size.height / 2);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 0.5);
    var endPoint = Offset(size.width, size.height / 1.5);

    var path = Path();

    path.lineTo(0, size.height);
    // path.moveTo(startPoint.dx, startPoint.dy);
    // path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
    //     controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.quadraticBezierTo(
        size.width * 0.30, size.height * 1, size.width * 0.40, size.height * 1);

    path.quadraticBezierTo(size.width * 0.6, size.height * 1, size.width * 0.70,
        size.height * 1.20);

    path.quadraticBezierTo(
        size.width * 1, size.height * 1.8, size.width * 1.2, 0);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
