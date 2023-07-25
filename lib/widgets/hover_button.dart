import 'package:craftor_gradient_picker/widgets/scale_tap.dart';
import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final Widget child;
  final BoxDecoration decoration;
  final Function() onTap;
  final Color color;
  final Color hoverColor;
  final EdgeInsets? padding;
  final String? tooltip;

  const HoverButton({
    Key? key,
    required this.child,
    required this.decoration,
    required this.onTap,
    required this.color,
    required this.hoverColor,
    this.padding,
    this.tooltip,
  }) : super(key: key);

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: Tooltip(
        message: widget.tooltip ?? '',
        child: ScaleTap(
          scaleMinValue: 0.95,
          duration: const Duration(milliseconds: 100),
          onPressed: widget.onTap,
          opacityMinValue: 0.75,
          child: AnimatedContainer(
            padding: widget.padding ?? const EdgeInsets.all(2),
            duration: const Duration(milliseconds: 200),
            decoration: widget.decoration.copyWith(
              color: isHover ? widget.hoverColor : widget.color,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class HoverTextButton extends StatefulWidget {
  final String text;
  final BoxDecoration decoration;
  final Function() onTap;
  final Color color;
  final Color hoverColor;
  final Color textColor;
  final Color textHoverColor;
  final EdgeInsets? padding;
  final String? tooltip;

  const HoverTextButton({
    Key? key,
    required this.text,
    required this.decoration,
    required this.onTap,
    required this.color,
    required this.hoverColor,
    required this.textColor,
    required this.textHoverColor,
    this.padding,
    this.tooltip,
  }) : super(key: key);

  @override
  State<HoverTextButton> createState() => _HoverTextButtonState();
}

class _HoverTextButtonState extends State<HoverTextButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: Tooltip(
        message: widget.tooltip ?? '',
        child: ScaleTap(
          scaleMinValue: 0.95,
          duration: const Duration(milliseconds: 100),
          onPressed: widget.onTap,
          opacityMinValue: 0.75,
          child: AnimatedContainer(
            padding: widget.padding ?? const EdgeInsets.all(2),
            duration: const Duration(milliseconds: 200),
            decoration: widget.decoration.copyWith(
              color: isHover ? widget.hoverColor : widget.color,
            ),
            width: 150,
            child: Center(
              child: Text(
                widget.text.toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: !isHover ? widget.textHoverColor : widget.textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
