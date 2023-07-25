// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class CircleSlider extends StatefulWidget {
  final List<double> initialValues;
  final Function(List<double>) onChanged;
  final List<Color> colors;

  const CircleSlider({
    Key? key,
    required this.initialValues,
    required this.onChanged,
    required this.colors,
  }) : super(key: key);

  @override
  _CircleSliderState createState() => _CircleSliderState();
}

class _CircleSliderState extends State<CircleSlider> {
  List<double> pointerValues = [];
  List<Offset> pointerOffsets = [];

  @override
  void initState() {
    super.initState();
    pointerValues = List.from(widget.initialValues)
        .map((value) => _convertToDegrees(value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final diameter = constraints.maxWidth;
        final radius = diameter / 2;
        pointerOffsets = List.generate(
          pointerValues.length,
          (index) {
            final angle = _convertToRadians(pointerValues[index]) - pi / 2;
            final x = radius + radius * cos(angle);
            final y = radius + radius * sin(angle);
            return Offset(x, y);
          },
        );
        return SizedBox(
          width: diameter,
          height: diameter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  shape: BoxShape.circle,
                ),
              ),
              CustomPaint(
                painter: MyPainter(
                  p1: const Offset(50, 50),
                  p2: pointerOffsets[0],
                  color: Colors.blue,
                ),
              ),
              CustomPaint(
                painter: MyPainter(
                    color: Colors.red,
                    p1: const Offset(50, 50),
                    p2: pointerOffsets[1]),
              ),
              Center(
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              for (int index = 0; index < pointerOffsets.length; index++)
                Positioned(
                  left: pointerOffsets[index].dx - 5,
                  top: pointerOffsets[index].dy - 5,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        final dx = details.delta.dx;
                        final dy = details.delta.dy;
                        final newValue = pointerOffsets[index] + Offset(dx, dy);
                        final clampedValue = Offset(
                          newValue.dx.clamp(0, diameter),
                          newValue.dy.clamp(0, diameter),
                        );
                        pointerOffsets[index] = clampedValue;

                        final angle = atan2(
                          clampedValue.dy - radius,
                          clampedValue.dx - radius,
                        );

                        double degrees = _convertToDegrees(angle + pi / 2);
                        if (degrees < 0) {
                          degrees += 360;
                        }
                        pointerValues[index] = degrees;
                        pointerValues = [...pointerValues];
                      });

                      widget.onChanged(pointerValues
                          .map((e) => _convertToRadians(e))
                          .toList());
                    },
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                        color: widget.colors[index],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  double _convertToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double _convertToDegrees(double radians) {
    return radians * 180.0 / pi;
  }
}

class MyPainter extends CustomPainter {
  final Offset p1;
  final Offset p2;
  final Color color;
  MyPainter({
    required this.p1,
    required this.p2,
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      p1,
      p2,
      Paint()
        ..color = color
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
