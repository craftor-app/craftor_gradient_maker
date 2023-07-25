// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class LinearGradientBox extends StatefulWidget {
  final LinearGradient value;
  final Offset start;
  final Offset end;
  final Function(
    Offset start,
    Offset end,
    FractionalOffset starting,
    FractionalOffset ending,
  ) onChanged;

  const LinearGradientBox({
    Key? key,
    required this.value,
    required this.start,
    required this.end,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<LinearGradientBox> createState() => _LinearGradientBoxState();
}

class _LinearGradientBoxState extends State<LinearGradientBox> {
  final GlobalKey key = GlobalKey();

  Offset start = Offset.zero;
  Offset end = const Offset(30, 40);
  FractionalOffset starting = FractionalOffset.topLeft;
  FractionalOffset ending = FractionalOffset.bottomRight;

  @override
  void initState() {
    setState(() {
      starting = widget.value.begin as FractionalOffset;
      ending = widget.value.end as FractionalOffset;
      start = widget.start;
      end = widget.end;
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LinearGradientBox oldWidget) {
    if (oldWidget.value != widget.value) {
      setState(() {
        starting = widget.value.begin as FractionalOffset;
        ending = widget.value.end as FractionalOffset;
        start = widget.start;
        end = widget.end;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: AppTheme.selectedSelectedColor.withOpacity(0.1),
            border: Border.all(
                color: AppTheme.textColor.withOpacity(0.3), width: 0.3),
            borderRadius: BorderRadius.circular(10)),
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/opacity.png"),
              ),
            ),
            child: Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  end: ending,
                  begin: starting,
                  stops: widget.value.stops,
                  colors: widget.value.colors,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: MyPainter(
                        start.translate(5, 5),
                        end.translate(5, 5),
                      ),
                    ),
                  ),
                  Positioned(
                    left: start.dx,
                    top: start.dy,
                    child: DeferPointer(
                      child: GestureDetector(
                        onPanUpdate: changeStarting,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: end.dx,
                    top: end.dy,
                    child: DeferPointer(
                      child: GestureDetector(
                        onPanUpdate: changeEnding,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  changeStarting(details) {
    final box = key.currentContext!.findRenderObject() as RenderBox;
    final size = box.size;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );

    final newStart = start + details.delta;
    if (newStart.dx >= -50 &&
        newStart.dx <= size.width - 60 &&
        newStart.dy >= -50 &&
        newStart.dy <= size.height - 60) {
      setState(() {
        start = newStart;
        starting = FractionalOffset.fromOffsetAndRect(start, rect);
      });
    }
    widget.onChanged(start, end, starting, ending);
  }

  changeEnding(details) {
    final box = key.currentContext!.findRenderObject() as RenderBox;
    final size = box.size;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );
    final newEnd = end + details.delta;
    if (newEnd.dx >= -50 &&
        newEnd.dx <= size.width - 60 &&
        newEnd.dy >= -50 &&
        newEnd.dy <= size.height - 60) {
      setState(() {
        end = newEnd;
        ending = FractionalOffset.fromOffsetAndRect(
          end,
          rect,
        );
      });
    }
    widget.onChanged(start, end, starting, ending);
  }
}

class MyPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final List<double> points = [];

  MyPainter(this.start, this.end);
  @override
  void paint(Canvas canvas, Size size) {
    drawLine(canvas);
  }

  drawLine(Canvas canvas) {
    final p1 = start;
    final p2 = end;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
