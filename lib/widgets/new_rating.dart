import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/controllers/new_rating_controller.dart';
import 'package:mood_log/services/db.dart';
import 'package:mood_log/widgets/color_box.dart';
import 'package:mood_log/models/rating.dart';

class NewRating extends StatefulWidget {
  final Function refresher;
  final DateTime date;
  final RatingValue? rating;
  final String? note;
  const NewRating(
      {Key? key,
      required this.refresher,
      required this.date,
      this.rating,
      this.note})
      : super(key: key);

  @override
  _NewRatingState createState() => _NewRatingState();
}

class _NewRatingState extends State<NewRating> {
  NewRatingController controller = NewRatingController();

  @override
  void initState() {
    super.initState();
    controller.setDate(widget.date);
    if (widget.rating != null)
      controller.selected[widget.rating!.index - 1] = true;
    if (widget.note != null) controller.noteController.text = widget.note!;
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
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Rate your day',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ToggleButtons(
                isSelected: controller.selected,
                selectedColor: Theme.of(context).textTheme.bodyMedium?.color,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                children: [
                  ColorBox(value: RatingValue.one, controller: controller),
                  ColorBox(value: RatingValue.two, controller: controller),
                  ColorBox(value: RatingValue.three, controller: controller),
                  ColorBox(value: RatingValue.four, controller: controller),
                  ColorBox(value: RatingValue.five, controller: controller),
                ],
                onPressed: (int index) {
                  setState(() {
                    controller.setValue(index);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                maxLines: 4,
                controller: controller.noteController,
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
                  initialDateTime: controller.selectedDate,
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    controller.setDate(newDate);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: controller.getValue() == 0
                    ? null
                    : () {
                        controller.updateRating(
                            DatabaseService().formatDate(widget.date));
                        Navigator.pop(context);
                        widget.refresher(() {});
                      },
                child: const Text('Save', style: TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(height: 20),
          ]),
    );
  }
}
