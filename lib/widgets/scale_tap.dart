// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

final Curve _DEFAULT_SCALE_CURVE = CurveSpring();
const Curve _DEFAULT_OPACITY_CURVE = Curves.ease;
const Duration _DEFAULT_DURATION = Duration(milliseconds: 300);

class ScaleTapConfig {
  static double? scaleMinValue;
  static Curve? scaleCurve;
  static double? opacityMinValue;
  static Curve? opacityCurve;
  static Duration? duration;
}

class ScaleTap extends StatefulWidget {
  final Function()? onPressed;
  final Function()? onLongPress;
  final Widget? child;
  final Duration? duration;
  final double? scaleMinValue;
  final Curve? scaleCurve;
  final Curve? opacityCurve;
  final double? opacityMinValue;
  final bool enableFeedback;

  const ScaleTap({
    super.key,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    required this.child,
    this.duration,
    this.scaleMinValue,
    this.opacityMinValue,
    this.scaleCurve,
    this.opacityCurve,
  });

  @override
  State<ScaleTap> createState() => ScaleTapState();
}

class ScaleTapState extends State<ScaleTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _scale = Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
    _opacity =
        Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> anim({double? scale, double? opacity, Duration? duration}) {
    _animationController.stop();
    _animationController.duration =
        duration ?? const Duration(milliseconds: 100);

    _scale = Tween<double>(
      begin: _scale.value,
      end: scale,
    ).animate(CurvedAnimation(
      curve: widget.scaleCurve ??
          ScaleTapConfig.scaleCurve ??
          _DEFAULT_SCALE_CURVE,
      parent: _animationController,
    ));
    _opacity = Tween<double>(
      begin: _opacity.value,
      end: opacity,
    ).animate(CurvedAnimation(
      curve: widget.opacityCurve ??
          ScaleTapConfig.opacityCurve ??
          _DEFAULT_OPACITY_CURVE,
      parent: _animationController,
    ));

    _animationController.reset();
    return _animationController.forward();
  }

  Future<void> _onTapUp() async {
    await anim(
      scale: widget.scaleMinValue ?? 0.999,
      opacity: widget.opacityMinValue ?? 0.7,
      duration: widget.duration ?? ScaleTapConfig.duration ?? _DEFAULT_DURATION,
    );
    await anim(
      scale: 1.0,
      opacity: 1.0,
      duration: widget.duration ?? ScaleTapConfig.duration ?? _DEFAULT_DURATION,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, Widget? child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            alignment: Alignment.center,
            scale: _scale.value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          if (widget.onPressed != null) {
            _onTapUp();
            widget.onPressed?.call();
          }
        },
        onLongPress: widget.onLongPress,
        child: widget.child,
      ),
    );
  }
}

class CurveSpring extends Curve {
  final SpringSimulation sim;

  CurveSpring() : sim = _sim(70, 20);

  @override
  double transform(double t) => sim.x(t) + t * (1 - sim.x(1.0));
}

_sim(double stiffness, double damping) => SpringSimulation(
      SpringDescription.withDampingRatio(
        mass: 1,
        stiffness: stiffness,
        ratio: 0.7,
      ),
      0.0,
      1.0,
      0.0,
    );
