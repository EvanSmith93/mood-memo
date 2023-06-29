import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/new_rating_controller.dart';
import 'package:mood_memo/widgets/color_box.dart';
import 'package:mood_memo/models/rating.dart';

class NewRating extends StatefulWidget {
  final NewRatingController controller;
  final Function refresher;
  final DateTime? date;
  final RatingValue? rating;
  final String? note;
  const NewRating(
      {Key? key,
      required this.controller,
      required this.refresher,
      this.date,
      this.rating,
      this.note})
      : super(key: key);

  @override
  State<NewRating> createState() => _NewRatingState();
}

class _NewRatingState extends State<NewRating> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Rate your day',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ToggleButtons(
                isSelected: widget.controller.selected,
                color: Colors.white,
                selectedColor: Colors.white,
                //selectedColor: Theme.of(context).textTheme.bodyMedium?.color,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                children: [
                  ColorBox(
                      value: RatingValue.one, controller: widget.controller),
                  ColorBox(
                      value: RatingValue.two, controller: widget.controller),
                  ColorBox(
                      value: RatingValue.three, controller: widget.controller),
                  ColorBox(
                      value: RatingValue.four, controller: widget.controller),
                  ColorBox(
                      value: RatingValue.five, controller: widget.controller),
                ],
                onPressed: (int index) {
                  setState(() {
                    widget.controller.setValue(index);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                maxLines: 5,
                controller: widget.controller.noteController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Note',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 130,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: widget.controller.getDate(),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      widget.controller.setDate(newDate);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: widget.controller.getValue() == 0
                    ? null
                    : () async {
                        widget.controller
                            .saveRating(widget.date, widget.refresher);
                      },
                child: const Text('Save', style: TextStyle(fontSize: 28, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
          ]),
    );
  }
}
