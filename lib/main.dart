import 'package:craftor_gradient_picker/helpers.dart';
import 'package:craftor_gradient_picker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'gradient_maker/gradient_maker.dart';
import 'models/element_gradient.dart';
import 'widgets/hover_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Craftor Gradient Maker',
      theme: AppTheme.getThemeData(context),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final initalGradient = ElementGradient(
    sweepStartAngle: 0,
    sweepEndAngle: 2,
    sweepCirlceOffset: const Offset(350 / 2, 250 / 2),
    sweepCenter: FractionalOffset.center,
    selectedGradient: "Linear",
    linearStart: FractionalOffset.topLeft,
    linearEnd: FractionalOffset.bottomRight,
    linearTo: const Offset(340, 240),
    linearFrom: Offset.zero,
    radialCenter: FractionalOffset.center,
    radialFocal: FractionalOffset.center,
    radialCircleOffset: const Offset(350 / 2, 250 / 2),
    radialFocalOffset: const Offset(100 / 2, 100 / 2),
    colors: [Colors.red, Colors.pink, Colors.blue],
    stops: [0.05, 0.3, 1],
  );
  final GlobalKey widgetKey = GlobalKey();

  OverlayEntry? entry;

  void onTap(String text) {
    setState(() {
      entry = OverlayEntry(
          maintainState: true,
          builder: (context) => Container(
                decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[11],
                    gradient: const LinearGradient(
                      colors: [Colors.black87, Colors.black54],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      child: TapRegion(
                        onTapOutside: (d) {
                          entry!.remove();
                          setState(() {
                            entry = null;
                          });
                        },
                        child: Container(
                            decoration:
                                const BoxDecoration(color: AppTheme.bgColor),
                            width: 350,
                            height: 450,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    16.h,
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/gradient.jpeg",
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    10.h,
                                    Text(
                                      "Craftor ".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.5,
                                        color: AppTheme.textColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    10.h,
                                    const Divider(),
                                    10.h,
                                    Text(
                                        "Your code is copied to clipboard!"
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          letterSpacing: 1.5,
                                          color: AppTheme.textColor,
                                        )),
                                    10.h,
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppTheme.selectedSelectedColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SelectableText(
                                            text,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    10.h,
                                    const Divider(),
                                    10.h,
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: HoverTextButton(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    AppTheme.defaultRadius,
                                                border: Border.all(
                                                    width: 0.3,
                                                    color: AppTheme.textColor
                                                        .withOpacity(0.3)),
                                              ),
                                              onTap: () => launchUrlString(
                                                  "https://craftor.app"),
                                              text: "Visit craftor",
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              color: AppTheme.selectedColor
                                                  .withOpacity(0.7),
                                              hoverColor: Colors.white,
                                              textHoverColor:
                                                  AppTheme.textColor,
                                              textColor: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.h,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Made with ❤️ by ".toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 1.5,
                                              color: AppTheme.textColor,
                                            )),
                                        InkWell(
                                          onTap: () {
                                            launchUrlString(
                                                "https://anshrathod.com");
                                          },
                                          child: Text(
                                            "ansh rathod".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              decoration:
                                                  TextDecoration.underline,
                                              letterSpacing: 1.2,
                                              color: Colors.blue.shade300
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ));
    });
    Overlay.of(context).insert(entry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 27, 27),
      body: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        if (width > 780 && height > 500) {
          return Center(
            child: GradientMaker(
              gradient: initalGradient,
              onGradientChange: (ElementGradient gradient) async {
                await Clipboard.setData(
                    ClipboardData(text: gradient.getString()));
                onTap(gradient.getString());
              },
            ),
          );
        } else {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                16.h,
                Image.asset(
                  "/assets/gradient.jpeg",
                  width: 60,
                  height: 60,
                ),
                10.h,
                Text(
                  "Craftor ".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.5,
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.h,
                const Divider(),
                10.h,
                Text(
                    "Sorry! but please adjust the window size upto 780x500."
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.5,
                      color: AppTheme.textColor,
                    )),
                10.h,
              ],
            ),
          );
        }
      }),
    );
  }
}
