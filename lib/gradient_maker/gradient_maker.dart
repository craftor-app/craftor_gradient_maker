// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:craftor_gradient_picker/gradient_maker/linear_gradient.dart';
import 'package:craftor_gradient_picker/helpers.dart';
import 'package:craftor_gradient_picker/widgets/hover_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../theme.dart';
import '../models/element_gradient.dart';
import '../widgets/custom_drop_down.dart';
import 'custom_slider.dart';
import 'gradient_color_picker.dart';
import 'radial_gradient.dart';
import 'sweep_gradient.dart';

class GradientMaker extends StatefulWidget {
  final ElementGradient gradient;
  final Function(ElementGradient) onGradientChange;
  const GradientMaker({
    Key? key,
    required this.gradient,
    required this.onGradientChange,
  }) : super(key: key);

  @override
  State<GradientMaker> createState() => _GradientMakerState();
}

class _GradientMakerState extends State<GradientMaker> {
  late ElementGradient gradient;

  @override
  void initState() {
    gradient = widget.gradient;
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant GradientMaker oldWidget) {
  //   if (oldWidget.gradient != widget.gradient) {
  //     gradient = widget.gradient;
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppTheme.defaultRadius,
      child: Material(
        child: Container(
          height: 500,
          width: 775,
          decoration: const BoxDecoration(
            borderRadius: AppTheme.defaultRadius,
            color: Color.fromARGB(255, 28, 27, 27),
          ),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              8.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Craftor Gradient maker".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.5,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.bold,
                          )),
                      5.h,
                      Row(
                        children: [
                          Text("Built by solo developer ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 1.2,
                                color: AppTheme.textColor.withOpacity(0.7),
                              )),
                          InkWell(
                            onTap: () {
                              launchUrlString("https://anshrathod.com");
                            },
                            child: Text(
                              "ansh rathod".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                                letterSpacing: 1.2,
                                color: Colors.blue.shade300.withOpacity(0.7),
                              ),
                            ),
                          ),
                          Text(". part of the ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 1.2,
                                color: AppTheme.textColor.withOpacity(0.7),
                              )),
                          InkWell(
                            onTap: () {
                              launchUrlString("https://use-craftor.com");
                            },
                            child: Text(
                              "Craftor".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                letterSpacing: 1.2,
                                color: Colors.blue.shade300.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  HoverButton(
                    onTap: () {
                      launchUrlString("https://x.com/use-craftor");
                    },
                    padding: const EdgeInsets.all(6),
                    color: AppTheme.selectedColor,
                    hoverColor: AppTheme.selectedSelectedColor.withOpacity(0.6),
                    decoration: BoxDecoration(
                      color: AppTheme.selectedSelectedColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.twitter,
                      size: 16,
                      color: AppTheme.textColor,
                    ),
                  ),
                  10.w,
                  HoverButton(
                    onTap: () {
                      launchUrlString(
                          "https://github.com/use-craftor/gradient_picker");
                    },
                    padding: const EdgeInsets.all(6),
                    color: AppTheme.selectedColor,
                    hoverColor: AppTheme.selectedSelectedColor.withOpacity(0.6),
                    decoration: BoxDecoration(
                      color: AppTheme.selectedSelectedColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.github,
                      size: 16,
                      color: AppTheme.textColor,
                    ),
                  ),
                ],
              ),
              24.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (gradient.selectedGradient == "Linear")
                    LinearGradientBox(
                      value: gradient.linearGradient,
                      start: gradient.linearFrom,
                      end: gradient.linearTo,
                      onChanged: (sO, eO, s, e) {
                        setState(() {
                          gradient = gradient.copyWith(
                            linearStart: s,
                            linearEnd: e,
                            linearFrom: sO,
                            linearTo: eO,
                          );
                        });
                      },
                    ),
                  if (gradient.selectedGradient == "Radial")
                    RadialGradientBox(
                      value: gradient.radialGradient,
                      onChanged: (offset, focalOffset, center, focal) {
                        setState(() {
                          gradient = gradient.copyWith(
                            radialCenter: center,
                            radialFocal: focal,
                            radialCircleOffset: offset,
                            radialFocalOffset: focalOffset,
                          );
                        });
                      },
                      offset: gradient.radialCircleOffset,
                      focalOffset: gradient.radialFocalOffset,
                    ),
                  if (gradient.selectedGradient == "Sweep")
                    SweepGradientBox(
                      value: gradient.sweepGradient,
                      onChanged: (offset, center, start, end) {
                        setState(() {
                          gradient = gradient.copyWith(
                            sweepCenter: center,
                            sweepCirlceOffset: offset,
                            sweepStartAngle: start,
                            sweepEndAngle: end,
                          );
                        });
                      },
                      offset: gradient.sweepCirlceOffset,
                    ),
                  20.w,
                  Container(
                    width: 270,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.selectedSelectedColor.withOpacity(0.1),
                      borderRadius: AppTheme.defaultRadius,
                      border: Border.all(
                          width: 0.3,
                          color: AppTheme.textColor.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textColor,
                                ),
                              ),
                              16.h,
                              CustomDropDown(
                                closeOnSelect: true,
                                value: gradient.selectedGradient,
                                items: const ["Linear", "Radial", "Sweep"],
                                height: 100,
                                onChanged: (String v) {
                                  setState(() {
                                    gradient = gradient.copyWith(
                                      selectedGradient: v,
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        14.h,
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Adjust Gradient".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textColor,
                            ),
                          ),
                        ),
                        CustomSlider(
                          initialValues: gradient.stops,
                          onChanged: (v) {
                            setState(() {
                              gradient = gradient.copyWith(
                                stops: [...v],
                              );
                            });
                          },
                          colors: gradient.colors,
                        ),
                        14.h,
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Colors".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textColor,
                                ),
                              ),
                              const Spacer(),
                              HoverButton(
                                decoration: BoxDecoration(
                                  color: AppTheme.selectedSelectedColor
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onTap: () {
                                  setState(() {
                                    gradient = gradient.copyWith(
                                      stops: [...gradient.stops, 1],
                                      colors: [...gradient.colors, Colors.blue],
                                    );
                                  });
                                },
                                color: Colors.transparent,
                                hoverColor: AppTheme.selectedSelectedColor,
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: AppTheme.textColor,
                                ),
                              ),
                              4.w
                            ],
                          ),
                        ),
                        10.h,
                        SizedBox(
                          height: 120,
                          child: SingleChildScrollView(
                            child: Column(children: [
                              for (var c in gradient.colors) ...[
                                GradientColorPicker(
                                  value: c,
                                  onRemove: () {
                                    List<Color> newColors = [
                                      ...gradient.colors
                                    ];

                                    final index = newColors.indexOf(c);
                                    newColors.removeAt(index);

                                    setState(() {
                                      gradient = gradient.copyWith(
                                        stops: [...gradient.stops]
                                          ..removeAt(index),
                                        colors: [...newColors],
                                      );
                                    });
                                  },
                                  height: 440,
                                  onChanged: (v) {
                                    List<Color> newColors = [
                                      ...gradient.colors
                                    ];

                                    final index = newColors.indexOf(c);
                                    newColors.removeAt(index);
                                    newColors.insert(index, v);

                                    setState(() {
                                      gradient = gradient
                                          .copyWith(colors: [...newColors]);
                                    });
                                  },
                                ),
                                10.h,
                              ]
                            ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              16.h,
              HoverTextButton(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppTheme.defaultRadius,
                  border: Border.all(
                      width: 0.3, color: AppTheme.textColor.withOpacity(0.3)),
                ),
                onTap: () => widget.onGradientChange(gradient),
                text: "Copy code",
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: AppTheme.selectedColor.withOpacity(0.7),
                hoverColor: Colors.white,
                textHoverColor: AppTheme.textColor,
                textColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
