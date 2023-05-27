import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/controllers/detail_page_controller.dart';
import 'package:mood_log/models/rating.dart';

class DetailPage extends StatefulWidget {
  final Rating rating;
  final Function refresher;
  DetailPage({super.key, required this.rating, required this.refresher});

  final DetailPageController controller = DetailPageController();

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rating.getPrettyDate()),
        backgroundColor: widget.rating.value.color,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
                widget.controller.editRating(widget.refresher, widget.rating);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  widget.rating.value.icon,
                  size: 70,
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.rating.value.word,
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      LinearProgressIndicator(
                        value: widget.rating.value.number / 5,
                        minHeight: 8,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[400]
                                : Colors.grey[600],
                        color: widget.rating.value.color,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            if (widget.rating.note.isNotEmpty) // Check if the note exists
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note',
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).hintColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.rating.note,
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            if (widget
                .rating.note.isEmpty) // Show "No note" if the note is empty
              Center(
                child: Text(
                  'No note',
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).hintColor),
                ),
              ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.controller.showDeleteAlert(
                      context, widget.refresher, widget.rating);
                },
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
