import 'package:flutter/material.dart';

extension EmptySpace on num {
  SizedBox get h => SizedBox(height: toDouble());

  SizedBox get w => SizedBox(width: toDouble());
}

const double boxHeight = 250.0;
const double boxWidth = 350.0;

const double circleHeight = 10;
const double circleWidth = 10;
