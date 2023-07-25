// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:craftor_gradient_picker/helpers.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import '../widgets/hover_button.dart';

class GradientColorPicker extends StatefulWidget {
  final Color value;
  final double height;
  final Function() onRemove;
  final Function(Color value) onChanged;
  const GradientColorPicker({
    Key? key,
    required this.value,
    required this.height,
    required this.onRemove,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<GradientColorPicker> createState() => GradientColorPickerState();
}

class GradientColorPickerState extends State<GradientColorPicker> {
  final GlobalKey _widgetKey = GlobalKey();

  Offset position = Offset.zero;

  OverlayEntry? entry;
  Color value = Colors.black;

  TextEditingController controller = TextEditingController();
  TextEditingController opacityController = TextEditingController();
  @override
  void initState() {
    setState(() {
      value = widget.value;
      controller.text =
          "#${value.value.toRadixString(16).replaceRange(0, 2, "").toUpperCase()}";
      opacityController.text = "${(value.opacity * 100).toInt()}%";
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant GradientColorPicker oldWidget) {
    if (oldWidget.value != widget.value) {
      setState(() {
        value = widget.value;
        controller.text =
            "#${value.value.toRadixString(16).replaceRange(0, 2, "").toUpperCase()}";
        opacityController.text = "${(value.opacity * 100).toInt()}%";
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      key: _widgetKey,
      onTap: () {
        if (entry != null) {
          entry!.remove();
          setState(() {
            entry = null;
          });
          return;
        } else {
          final RenderBox? renderBox =
              _widgetKey.currentContext?.findRenderObject() as RenderBox?;
          var offset = renderBox!.localToGlobal(Offset.zero);
          if (size.width - offset.dx < renderBox.size.width + 10) {
            offset = Offset(offset.dx - renderBox.size.width, offset.dy);
            position = Offset(
              offset.dx,
              MediaQuery.sizeOf(context).height - widget.height - 80,
            );
          }
          setState(() {
            entry = OverlayEntry(
              maintainState: true,
              builder: (context) => Positioned(
                top: position.dy,
                left: position.dx,
                child: TapRegion(
                  onTapOutside: (v) {
                    var rect = Rect.fromLTWH(
                      position.dx,
                      position.dy,
                      renderBox.size.width,
                      renderBox.size.height,
                    );
                    if (!rect.contains(v.position)) {
                      if (entry != null) {
                        entry!.remove();
                        setState(() {
                          entry = null;
                        });
                      }
                    }
                  },
                  child: ClipRRect(
                    borderRadius: AppTheme.defaultRadius,
                    child: Container(
                      height: widget.height,
                      width: 260,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.7, color: AppTheme.selectedSelectedColor),
                        borderRadius: AppTheme.defaultRadius,
                        color: AppTheme.selectedColor,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onPanUpdate: (d) {
                              Overlay.of(context).setState(() {
                                position = Offset(position.dx + d.delta.dx,
                                    position.dy + d.delta.dy);
                              });
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.move,
                              child: Container(
                                height: 20,
                                color: AppTheme.selectedSelectedColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Material(
                                child: ColorPicker(
                                  color: value,
                                  opacityTrackHeight: 10,
                                  wheelDiameter: 180,
                                  opacityThumbRadius: 12,
                                  width: 20,
                                  recentColors: const [Colors.black],
                                  wheelWidth: 10,
                                  wheelSquarePadding: 10,
                                  height: 20,
                                  opacitySubheading: Text(
                                    "Opacity".toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      height: 2,
                                      color: AppTheme.textColor,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  wheelSubheading: Text(
                                    "Shades".toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      height: 2,
                                      color: AppTheme.textColor,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  subheading: Text(
                                    "Shades".toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      height: 2,
                                      color: AppTheme.textColor,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  pickersEnabled: const <ColorPickerType, bool>{
                                    ColorPickerType.wheel: true,
                                    ColorPickerType.accent: false,
                                    ColorPickerType.primary: false,
                                    ColorPickerType.custom: true,
                                  },
                                  customColorSwatchesAndNames: <ColorSwatch<
                                          Object>,
                                      String>{
                                    const MaterialColor(
                                        0xFFfae738, <int, Color>{
                                      50: Color(0xFFfffee9),
                                      100: Color(0xFFfff9c6),
                                      200: Color(0xFFfff59f),
                                      300: Color(0xFFfff178),
                                      400: Color(0xFFfdec59),
                                      500: Color(0xFFfae738),
                                      600: Color(0xFFf3dd3d),
                                      700: Color(0xFFdfc735),
                                      800: Color(0xFFcbb02f),
                                      900: Color(0xFFab8923),
                                    }): 'Alpine',
                                    ColorTools.createPrimarySwatch(
                                        const Color(0xFFBC350F)): 'Rust',
                                    ColorTools.createAccentSwatch(
                                        const Color(0xFFB062DB)): 'Lavender',
                                  },
                                  showRecentColors: false,
                                  enableOpacity: true,
                                  onColorChanged: (c) {
                                    widget.onChanged(c);
                                    setState(() {
                                      value = c;
                                    });
                                    controller.text =
                                        "#${c.value.toRadixString(16).replaceRange(0, 2, "").toUpperCase()}";

                                    opacityController.text =
                                        "${(c.opacity * 100).toInt()}%";
                                    Overlay.of(context).setState(() {
                                      value = c;
                                    });
                                  },
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
          });
        }
        Overlay.of(context).insert(entry!);
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.selectedColor,
          border: entry != null
              ? Border.all(
                  width: 0.7,
                  color: AppTheme.selectedSelectedColor,
                )
              : null,
          borderRadius: AppTheme.defaultRadius,
        ),
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: value,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 1,
                  color: AppTheme.selectedSelectedColor,
                ),
              ),
            ),
            5.w,
            Expanded(
              child: TextFormField(
                controller: controller,
                maxLines: 1,
                onFieldSubmitted: (v) {
                  setState(() {
                    value = Color(int.parse("0xff${v.replaceAll("#", "")}"));
                    controller.text =
                        "#${value.value.toRadixString(16).replaceRange(0, 2, "").toUpperCase()}";

                    opacityController.text =
                        "${(value.opacity * 100).toInt()}%";
                  });
                  widget.onChanged(value);
                },
                onTap: () {
                  setState(() {
                    controller.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.text.length,
                    );
                  });
                },
                decoration: const InputDecoration(
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.selectedSelectedColor,
                      width: 1,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                ),
                style: const TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.4,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 16,
              color: AppTheme.selectedSelectedColor,
            ),
            SizedBox(
              width: 70,
              child: TextFormField(
                controller: opacityController,
                maxLines: 1,
                onFieldSubmitted: (v) {
                  Overlay.of(context).setState(() {
                    value = value.withOpacity(
                        double.parse(v.replaceAll("%", "")) * 0.01);
                  });
                  opacityController.text = "${double.parse(v).toInt()}%";
                  widget.onChanged(value);
                },
                onTap: () {
                  setState(() {
                    // opacityController.text =
                    //     opacityController.text.replaceAll("%", "");

                    opacityController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: opacityController.text.length,
                    );
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RangeTextInputFormatter(min: -1, max: 100),
                ],
                decoration: const InputDecoration(
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.selectedSelectedColor,
                      width: 1,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                ),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 1,
              height: 16,
              color: AppTheme.selectedSelectedColor,
            ),
            8.w,
            HoverButton(
              decoration: BoxDecoration(
                color: AppTheme.selectedSelectedColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              onTap: widget.onRemove,
              color: Colors.transparent,
              hoverColor: AppTheme.selectedSelectedColor,
              child: const Icon(
                Icons.close,
                size: 16,
                color: AppTheme.textColor,
              ),
            ),
            8.w
          ],
        ),
      ),
    );
  }
}

class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (double.tryParse(newValue.text) == null) {
      return oldValue;
    } else {
      final intValue = double.parse(newValue.text);
      if (intValue < min) {
        return TextEditingValue(
          text: min.toString(),
          selection: TextSelection.collapsed(offset: min.toString().length),
        );
      } else if (intValue > max) {
        return TextEditingValue(
          text: max.toString(),
          selection: TextSelection.collapsed(offset: max.toString().length),
        );
      } else {
        return newValue;
      }
    }
  }
}
