// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../theme.dart';

class CustomDropDown extends StatefulWidget {
  final String value;
  final List<String> items;
  final double height;
  final bool closeOnSelect;
  final Function(String value) onChanged;
  const CustomDropDown({
    Key? key,
    required this.value,
    required this.items,
    required this.height,
    required this.closeOnSelect,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  final GlobalKey _widgetKey = GlobalKey();

  OverlayEntry? entry;
  String value = "";

  @override
  void initState() {
    value = widget.value;
    super.initState();
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
          Overlay.of(context).setState(() {
            entry!.remove();
          });
          setState(() {
            entry = null;
          });
          return;
        } else {
          setState(() {
            final RenderBox? renderBox =
                _widgetKey.currentContext?.findRenderObject() as RenderBox?;
            var offset = renderBox!.localToGlobal(Offset.zero);
            if (size.width - offset.dx < renderBox.size.width + 10) {
              offset = Offset(offset.dx - renderBox.size.width, offset.dy);
            }
            entry = OverlayEntry(
              maintainState: true,
              builder: (context) => Positioned(
                top: offset.dy + 50,
                left: offset.dx,
                child: TapRegion(
                  onTapOutside: (v) {
                    var rect = Rect.fromLTWH(
                      offset.dx,
                      offset.dy,
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
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: widget.height,
                      width: renderBox.size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.selectedSelectedColor,
                          width: 0.5,
                        ),
                        color: AppTheme.selectedColor,
                      ),
                      padding: const EdgeInsets.only(top: 6),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, i) {
                          final isActive = value == widget.items[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                              vertical: 2,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: AppTheme.defaultRadius,
                                  color: isActive
                                      ? Colors.blue
                                      : Colors.transparent,
                                ),
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 3),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.items[i],
                                            style: TextStyle(
                                              color: isActive
                                                  ? Colors.white
                                                  : AppTheme.textColor,
                                            ),
                                          ),
                                        ),
                                        if (isActive)
                                          const Icon(Icons.check,
                                              size: 14, color: Colors.white)
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    widget.onChanged(widget.items[i]);
                                    Overlay.of(context).setState(() {
                                      value = widget.items[i];
                                    });
                                    if (entry != null && widget.closeOnSelect) {
                                      entry!.remove();
                                      setState(() {
                                        entry = null;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
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
                  color: AppTheme.selectedSelectedColor,
                  width: 0.5,
                )
              : null,
          borderRadius: AppTheme.defaultRadius,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: widget.value,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: AppTheme.textColor,
            ),
          ],
        ),
      ),
    );
  }
}
