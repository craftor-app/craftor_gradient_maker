import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final List<double> initialValues;
  final Function(List<double>) onChanged;
  final List<Color> colors;

  const CustomSlider({
    Key? key,
    required this.initialValues,
    required this.onChanged,
    required this.colors,
  }) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  List<double> pointerValues = [];
  List<Offset> pointerOffsets = [];

  @override
  void initState() {
    super.initState();
    pointerValues = List.from(widget.initialValues);
  }

  @override
  void didUpdateWidget(covariant CustomSlider oldWidget) {
    if (oldWidget.initialValues != widget.initialValues) {
      setState(() {
        pointerValues = List.from(widget.initialValues);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const height = 40.0; // Set a fixed height for the slider
        pointerOffsets = List.generate(
          pointerValues.length,
          (index) => Offset(pointerValues[index] * width, 0),
        );
        return SizedBox(
          height: height,
          child: OverflowBox(
            maxWidth: width,
            maxHeight: height,
            child: Stack(
              children: [
                Container(
                  height: height,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: widget.colors,
                        stops: pointerValues,
                      ),
                    ),
                    width: width,
                    height: 10,
                  ),
                ),
                for (int index = 0; index < pointerOffsets.length; index++)
                  Positioned(
                    left: (pointerOffsets[index].dx - 4).clamp(0.0, width - 16),
                    top: height / 2 - 10,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          final dx = details.delta.dx;
                          final newValue = pointerOffsets[index].dx + dx;
                          final clampedValue = newValue.clamp(0, width);
                          pointerOffsets[index] =
                              Offset(clampedValue.toDouble(), 0);
                          pointerValues[index] = clampedValue / width;
                          pointerValues = [...pointerValues];
                        });

                        widget.onChanged(pointerValues);
                      },
                      child: Column(children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(4),
                            color: widget.colors[index],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 5,
                          color: Colors.grey,
                        )
                      ]),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
