import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/edit_controller.dart';
import 'package:mood_memo/widgets/edit/color_box.dart';
import 'package:mood_memo/models/rating_value.dart';

class EditRating extends StatefulWidget {
  final NewRatingController controller;
  final Function refresher;
  final DateTime? date;
  final RatingValue? rating;
  final String? note;
  const EditRating(
      {Key? key,
      required this.controller,
      required this.refresher,
      this.date,
      this.rating,
      this.note})
      : super(key: key);

  @override
  State<EditRating> createState() => _EditRatingState();
}

class _EditRatingState extends State<EditRating> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Rate your day',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ToggleButtons(
                isSelected: widget.controller.selected,
                color: Colors.white,
                selectedColor: Colors.white,
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
              padding: const EdgeInsets.all(10),
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
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 130,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          Theme.of(context).textTheme.titleMedium,
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
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: widget.controller.getValue() == 0
                    ? null
                    : () {
                        widget.controller
                            .saveRating(widget.date, widget.refresher);
                      },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 10),
          ]),
    );
  }
}
