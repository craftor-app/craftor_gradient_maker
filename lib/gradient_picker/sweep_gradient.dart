// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:craftor_gradient_picker/helpers.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class SweepGradientBox extends StatefulWidget {
  final SweepGradient value;
  final Offset offset;
  final Function(
          Offset offset, FractionalOffset center, double start, double end)
      onChanged;
  const SweepGradientBox({
    Key? key,
    required this.value,
    required this.offset,
    required this.onChanged,
  }) : super(key: key);

  @override
  SweepGradientBoxState createState() => SweepGradientBoxState();
}

class SweepGradientBoxState extends State<SweepGradientBox> {
  FractionalOffset center = FractionalOffset.center;

  Offset offset = Offset.zero;

  double start = 0;
  double end = 360;

  @override
  void initState() {
    center = widget.value.center as FractionalOffset;
    offset = widget.offset;
    start = widget.value.startAngle * (180 / pi);
    end = widget.value.endAngle * (180 / pi);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant SweepGradientBox oldWidget) {
    if (oldWidget.value.colors != widget.value.colors) {
      setState(() {
        center = widget.value.center as FractionalOffset;
        offset = widget.offset;
        start = widget.value.startAngle * (180 / pi);
        end = widget.value.endAngle * (180 / pi);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void _updateCenter(Offset delta, Size size, rect) {
    setState(() {
      center = FractionalOffset.fromOffsetAndRect(offset, rect);
      offset += delta;
    });
    widget.onChanged(
      offset,
      center,
      start * pi / 180,
      end * pi / 180,
    );
  }

  GlobalKey key = GlobalKey();

  bool isStartDisable = false;
  bool isEndDisable = false;

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
        child: SizedBox(
          width: boxWidth + 100,
          height: boxHeight + 100,
          child: Column(
            children: [
              20.h,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Start".toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 8,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "end".toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 8,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              20.h,
              Row(
                children: [
                  20.w,
                  SizedBox(
                    height: 250,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 1,
                          activeTrackColor: Colors.blue,
                          inactiveTrackColor: Colors.grey.shade700,
                          thumbColor: Colors.white,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 5,
                            pressedElevation: 0,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 0,
                          ),
                        ),
                        child: Slider(
                          value: start,
                          max: 360,
                          min: 0,
                          onChanged: (double value) {
                            if (value >= end) {
                              setState(() {
                                isStartDisable = true;
                              });
                            } else {
                              setState(() {
                                isStartDisable = false;
                                start = value;
                              });
                              widget.onChanged(
                                offset,
                                center,
                                start * pi / 180,
                                end * pi / 180,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  20.w,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/opacity.png"),
                      ),
                    ),
                    child: Container(
                      key: key,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppTheme.textColor.withOpacity(0.3),
                            width: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: boxWidth,
                      height: boxHeight,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
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
                              width: boxWidth,
                              height: boxHeight,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppTheme.textColor.withOpacity(0.3),
                                  width: 0.3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                gradient: SweepGradient(
                                  center: center,
                                  startAngle: start * pi / 180,
                                  endAngle: end * pi / 180,
                                  stops: widget.value.stops,
                                  colors: widget.value.colors,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.w,
                  SizedBox(
                    height: 250,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 1,
                          activeTrackColor: Colors.blue,
                          inactiveTrackColor: Colors.grey.shade700,
                          thumbColor: Colors.white,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 5,
                            pressedElevation: 0,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 0,
                          ),
                        ),
                        child: Slider(
                          value: end,
                          max: 360,
                          min: 0,
                          onChanged: (double value) {
                            if (value <= start) {
                              setState(() {
                                isEndDisable = true;
                              });
                            } else {
                              setState(() {
                                end = value;
                              });
                              widget.onChanged(
                                offset,
                                center,
                                start * pi / 180,
                                end * pi / 180,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              16.h,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tip: ".toUpperCase(),
                      style: TextStyle(
                        color: AppTheme.textColor.withOpacity(0.7),
                        fontSize: 10,
                        height: 1.2,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Drag cursor on the gradient to move the center."
                          .toUpperCase(),
                      style: TextStyle(
                        color: AppTheme.textColor.withOpacity(0.7),
                        fontSize: 10,
                        height: 1.2,
                        decoration: TextDecoration.underline,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
