import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/controllers/new_rating_controller.dart';
import 'package:mood_log/main.dart';
import 'package:mood_log/services/db.dart';
import 'package:mood_log/widgets/color_box.dart';
import 'package:mood_log/models/rating.dart';

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
  _NewRatingState createState() => _NewRatingState();
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
            /*Container(
                    width: 50,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Rate your day',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),*/
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ToggleButtons(
                isSelected: widget.controller.selected,
                selectedColor: Theme.of(context).textTheme.bodyMedium?.color,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: widget.controller.getValue() == 0
                    ? null
                    : () async {
                        void saveRating() async {
                          await widget.controller.updateRating(DatabaseService().formatDate(widget.date ?? DateTime.now()));
                          Navigator.pop(navigatorKey.currentContext!);
                          widget.refresher(() {});
                        }
                        // this should go in the controller
                        if (widget.date != widget.controller.getDate() && await DatabaseService().getRatingFromDay(
                                widget.controller.getDate()) != null) {
                          showDialog(
                              context: navigatorKey.currentContext!,
                              builder: (context) => AlertDialog(
                                    title: const Text('Overwrite rating?'),
                                    content: const Text(
                                        'You have already rated this day. Are you sure you want to overwrite your previous rating?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            saveRating();
                                          },
                                          child: const Text('Overwrite')),
                                    ],
                                  ));
                        } else {
                          saveRating();
                        }
                      },
                child: const Text('Save', style: TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(height: 20),
          ]),
    );
  }
}
