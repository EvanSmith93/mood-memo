import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/models/rating.dart';

// I might change this code because it is sort of a duplucate of the calendar box

// stateless widget that takes one argument
class ColorBox extends StatelessWidget {
  const ColorBox({Key? key, required this.rating}) : super(key: key);

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    // return a container with a width and height of 100 and rounded corners
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: rating.color,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
      ),
    );
  }
}