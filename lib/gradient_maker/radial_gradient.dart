// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

import '../helpers.dart';
import '../theme.dart';

class RadialGradientBox extends StatefulWidget {
  final RadialGradient value;
  final Offset offset;
  final Offset focalOffset;
  final Function(Offset offset, Offset focalOffset, FractionalOffset center,
      FractionalOffset focal) onChanged;
  const RadialGradientBox({
    Key? key,
    required this.value,
    required this.offset,
    required this.focalOffset,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RadialGradientBoxState createState() => _RadialGradientBoxState();
}

class _RadialGradientBoxState extends State<RadialGradientBox> {
  FractionalOffset center = FractionalOffset.center;
  FractionalOffset focalCenter = FractionalOffset.center;

  Offset offset = Offset.zero;
  Offset focalOffset = const Offset(circleWidth / 2, circleHeight / 2);

  @override
  void initState() {
    center = widget.value.center as FractionalOffset;
    focalCenter = widget.value.focal as FractionalOffset;
    offset = widget.offset;
    focalOffset = widget.focalOffset;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant RadialGradientBox oldWidget) {
    if (oldWidget.value.colors != widget.value.colors) {
      setState(() {
        center = widget.value.center as FractionalOffset;
        focalCenter = widget.value.focal as FractionalOffset;
        offset = widget.offset;
        focalOffset = widget.focalOffset;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void _updateCenter(Offset delta, Size size, rect) {
    final newValue = offset + delta;
    if (newValue.dx >= -50 &&
        newValue.dx <= size.width + 50 &&
        newValue.dy >= -50 &&
        newValue.dy <= size.height + 50) {
      setState(() {
        center = FractionalOffset.fromOffsetAndRect(offset, rect);
        offset += delta;
      });
    }
    widget.onChanged(offset, focalOffset, center, focalCenter);
  }

  // void _updateFocal(Offset delta, Size size, rect) {
  //   if (focalOffset.dx + delta.dx > 0 &&
  //       focalOffset.dx + delta.dx < 90 &&
  //       focalOffset.dy + delta.dy > 0 &&
  //       focalOffset.dy + delta.dy < 90) {
  //     setState(() {
  //       focalCenter = FractionalOffset.fromOffsetAndRect(focalOffset, rect);
  //       focalOffset += delta;
  //     });
  //     widget.onChanged(offset, focalOffset, center, focalCenter);
  //   } else {
  //     return;
  //   }
  // }

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppTheme.selectedSelectedColor.withOpacity(0.1),
          border: Border.all(
              color: AppTheme.textColor.withOpacity(0.3), width: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
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
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppTheme.textColor.withOpacity(0.3), width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              width: boxWidth,
              height: boxHeight,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.textColor.withOpacity(0.3),
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      gradient: RadialGradient(
                        center: center,
                        // focal: focalCenter,
                        stops: widget.value.stops,
                        focalRadius: 0,
                        radius: 0.5,
                        colors: widget.value.colors,
                      ),
                    ),
                  ),
                  Positioned(
                    left: center
                        .withinRect(
                            const Rect.fromLTWH(0, 0, boxWidth, boxHeight))
                        .dx,
                    top: center
                        .withinRect(
                            const Rect.fromLTWH(0, 0, boxWidth, boxHeight))
                        .dy,
                    child: DeferPointer(
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          final box = key.currentContext!.findRenderObject()
                              as RenderBox;
                          final delta = details.delta;
                          final rect = Rect.fromCenter(
                              center: Offset(
                                  box.size.width / 2, box.size.height / 2),
                              width: box.size.width,
                              height: box.size.height);
                          _updateCenter(delta, box.size, rect);
                        },
                        child: Container(
                          width: circleWidth,
                          height: circleHeight,
                          decoration: BoxDecoration(
                              // color: Colors.white,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1, color: Colors.white)),

                          //NOTE: Focalpoint is too buggy or I'm too dumb to use it
                          // child: Stack(
                          //   children: [
                          //     Positioned(
                          //       left: focalOffset.dx - 5,
                          //       top: focalOffset.dy - 5,
                          //       child: GestureDetector(
                          //         onPanUpdate: (v) {
                          //           final delta = v.delta;
                          //           final rect = Rect.fromCenter(
                          //               center: const Offset(100, 100),
                          //               width: circleWidth,
                          //               height: circleHeight);
                          //           _updateFocal(
                          //               delta,
                          //               const Size(circleWidth, circleHeight),
                          //               rect);
                          //         },
                          //         child: Container(
                          //           width: 10,
                          //           height: 10,
                          //           decoration: const BoxDecoration(
                          //               color: Colors.white,
                          //               shape: BoxShape.circle),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
