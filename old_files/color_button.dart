import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/models/rating.dart';
import 'package:mood_log/widgets/color_box.dart';
import 'package:mood_log/controllers/new_rating_controller.dart';

// stateless widget that takes one argument
/*class ColorButton extends StatelessWidget {
  const ColorButton({Key? key, required this.rating, required this.controller})
      : super(key: key);

  final Rating rating;
  final RateDayController controller;

  @override
  Widget build(BuildContext context) {
    // return a container with a width and height of 100 and rounded corners
    return TextButton(
        onPressed: () {
          controller.setRating();
        },
        child: ColorBox(rating: rating));
  }
}
*/