import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/edit_controller.dart';
import 'package:mood_memo/models/rating_value.dart';
import 'dart:math' as math;

class ColorBox extends StatefulWidget {
  final RatingValue value;
  final NewRatingController controller;

  const ColorBox({Key? key, required this.value, required this.controller})
      : super(key: key);

  @override
  State<ColorBox> createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
        width: math.min(width * 0.2, 70),
        height: math.min(width * 0.2, 70),
        decoration: BoxDecoration(
          color: widget.value.color.withOpacity(
              widget.controller.isSelected(widget.value) ? 1 : 0.40),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Icon(
            widget.value.icon,
            size: widget.controller.isSelected(widget.value) ? math.min(width * 0.17, 60) : math.min(width * 0.1, 35),
          ),
        ),
      ),
    );
  }
}
