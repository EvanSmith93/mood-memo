import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/new_rating_controller.dart';
import 'package:mood_memo/models/rating.dart';

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
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 6,
      height: width / 6.5,
      decoration: BoxDecoration(
        color: widget.value.color
            .withOpacity(widget.controller.isSelected(widget.value) ? 1 : 0.8),
      ),
      child: Center(
        child: Icon(
          widget.value.icon,
          size: widget.controller.isSelected(widget.value)
              ? width / 7
              : width / 9.5,
        ),
      ),
    );
  }
}
