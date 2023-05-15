import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/controllers/new_rating_controller.dart';
import 'package:mood_log/widgets/color_box.dart';
import 'package:mood_log/models/rating.dart';
import 'package:mood_log/old_files/color_button.dart';

class NewRating extends StatefulWidget {
  final Function refresher;
  final DateTime? date;
  const NewRating({Key? key, required this.refresher, this.date}) : super(key: key);

  @override
  _NewRatingState createState() => _NewRatingState();
}

class _NewRatingState extends State<NewRating> {
  RateDayController controller = RateDayController();

  void initState() {
    super.initState();
    if (widget.date != null) {
      controller.setTimestamp(widget.date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 4,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Rate your day',
                style: TextStyle(fontSize: 30),
              ),
            ),
            ToggleButtons(
              isSelected: controller.selected,
              children: [
                ColorBox(
                    rating: Rating(
                        value: RatingValue.one, timestamp: DateTime.now(), note: "")),
                ColorBox(
                    rating: Rating(
                        value: RatingValue.two, timestamp: DateTime.now(), note: "")),
                ColorBox(
                    rating: Rating(
                        value: RatingValue.three, timestamp: DateTime.now(), note: "")),
                ColorBox(
                    rating: Rating(
                        value: RatingValue.four, timestamp: DateTime.now(), note: "")),
                ColorBox(
                    rating: Rating(
                        value: RatingValue.five, timestamp: DateTime.now(), note: "")),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < controller.selected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      controller.selected[buttonIndex] = true;
                    } else {
                      controller.selected[buttonIndex] = false;
                    }
                  }
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: 3,
                onChanged: (String value) {
                  controller.setNote(value);
                },
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Note',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 150,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: controller.selectedDate,
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    controller.setTimestamp(newDateTime);
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: controller.getValue() == 0 ? null : () {
                controller.setRating();
                Navigator.pop(context);
                // rebuild the home screen
                widget.refresher(() {});
              },
              child: const Text('Save', style: TextStyle(fontSize: 28)),
            ),
            const SizedBox(height: 20),
          ]),
    );
  }
}
