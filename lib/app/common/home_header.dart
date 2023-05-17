import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/style.dart';

class HeaderCurvedContainerHome extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = primaryColor;
    Path path = Path()
      ..relativeLineTo(0, 150.0)
      ..quadraticBezierTo(size.width / 2, 20.0, size.width, 150.0)
      ..relativeLineTo(0, -200)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}