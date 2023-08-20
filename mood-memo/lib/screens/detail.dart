import 'package:flutter/material.dart';
import 'package:mood_memo/controllers/detail_controller.dart';
import 'package:mood_memo/models/rating.dart';

class Detail extends StatefulWidget {
  final Rating rating;
  final Function refresher;
  Detail({super.key, required this.rating, required this.refresher});

  final DetailPageController controller = DetailPageController();

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.rating.getRelativeDate(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: widget.rating.value.color,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pop(context);
              widget.controller.editRating(widget.refresher, widget.rating);
            },
            icon: const Icon(Icons.edit),
          )
        ],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
                              style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                      const SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: widget.rating.value.number / 5,
                          minHeight: 8,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                          color: widget.rating.value.color,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: widget.rating.note.isNotEmpty,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Text(
                            widget.rating.note,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.rating.note.isEmpty,
              child: Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'No note',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                    textStyle: Theme.of(context).textTheme.titleSmall,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
