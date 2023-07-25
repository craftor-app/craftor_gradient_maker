import 'package:flutter/material.dart';

class ElementGradient {
  FractionalOffset linearEnd = const FractionalOffset(0.0, 0.0);
  FractionalOffset linearStart = const FractionalOffset(1.0, 1.0);
  Offset linearFrom = Offset.zero;
  Offset linearTo = const Offset(200, 200);
  FractionalOffset radialCenter = FractionalOffset.topLeft;
  FractionalOffset radialFocal = FractionalOffset.topLeft;
  Offset radialCircleOffset = Offset.zero;
  Offset radialFocalOffset = Offset.zero;
  List<Color> colors = [Colors.green, Colors.red];
  List<double> stops = [0.4, 1];

  double sweepStartAngle = 0;
  double sweepEndAngle = 360;
  Offset sweepCirlceOffset;
  FractionalOffset sweepCenter;

  String selectedGradient = "Linear";

  ElementGradient({
    required this.linearFrom,
    required this.linearTo,
    required this.linearEnd,
    required this.linearStart,
    required this.radialCenter,
    required this.radialFocal,
    required this.radialCircleOffset,
    required this.radialFocalOffset,
    required this.colors,
    required this.stops,
    required this.selectedGradient,
    required this.sweepEndAngle,
    required this.sweepStartAngle,
    required this.sweepCenter,
    required this.sweepCirlceOffset,
  });

  LinearGradient get linearGradient => LinearGradient(
        begin: linearStart,
        end: linearEnd,
        colors: colors,
        stops: stops,
      );

  RadialGradient get radialGradient => RadialGradient(
        center: radialCenter,
        focal: radialFocal,
        colors: colors,
        stops: stops,
      );

  SweepGradient get sweepGradient => SweepGradient(
        startAngle: sweepStartAngle,
        center: sweepCenter,
        endAngle: sweepEndAngle,
        colors: colors,
        stops: stops,
      );

  String getString() {
    if (selectedGradient == "Linear") {
      return "LinearGradient(\n   begin: $linearStart,\n   end: $linearEnd,\n   colors: ${colors.map((e) => "Color(${e.value})").toList()}  ,\n  stops: $stops,\n)";
    } else if (selectedGradient == "Radial") {
      return "RadialGradient(\n  center: $radialCenter,\n  focal: $radialFocal,\n  colors: ${colors.map((e) => "Color(${e.value})").toList()},\n  stops: $stops,\n)";
    } else {
      return "SweepGradient(\n  startAngle: $sweepStartAngle,\n  center: $sweepCenter,\n   endAngle: $sweepEndAngle,\n   colors: ${colors.map((e) => "Color(${e.value})").toList()},\n   stops: $stops,\n)";
    }
  }

  ElementGradient copyWith({
    Offset? linearFrom,
    FractionalOffset? radialCenter,
    FractionalOffset? radialFocal,
    Offset? radialCircleOffset,
    Offset? radialFocalOffset,
    List<Color>? colors,
    List<double>? stops,
    double? sweepStartAngle,
    double? sweepEndAngle,
    Offset? sweepCirlceOffset,
    FractionalOffset? sweepCenter,
    String? selectedGradient,
    Offset? linearTo,
    FractionalOffset? linearEnd,
    FractionalOffset? linearStart,
  }) {
    return ElementGradient(
      linearFrom: linearFrom ?? this.linearFrom,
      radialCenter: radialCenter ?? this.radialCenter,
      radialFocal: radialFocal ?? this.radialFocal,
      radialCircleOffset: radialCircleOffset ?? this.radialCircleOffset,
      radialFocalOffset: radialFocalOffset ?? this.radialFocalOffset,
      colors: colors ?? this.colors,
      stops: stops ?? this.stops,
      sweepStartAngle: sweepStartAngle ?? this.sweepStartAngle,
      sweepEndAngle: sweepEndAngle ?? this.sweepEndAngle,
      sweepCirlceOffset: sweepCirlceOffset ?? this.sweepCirlceOffset,
      sweepCenter: sweepCenter ?? this.sweepCenter,
      selectedGradient: selectedGradient ?? this.selectedGradient,
      linearTo: linearTo ?? this.linearTo,
      linearEnd: linearEnd ?? this.linearEnd,
      linearStart: linearStart ?? this.linearStart,
    );
  }
}
