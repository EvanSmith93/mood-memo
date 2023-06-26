import 'package:flutter/material.dart';
import 'package:mood_memo/controllers/list_controller.dart';
import 'package:mood_memo/models/rating.dart';

class ListItem extends StatefulWidget {
  final Rating rating;
  final RatingListController controller;
  const ListItem({super.key, required this.rating, required this.controller});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.rating.value.color,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.rating.getPrettyDate(),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                widget.rating.note != ""
                    ? Text(
                        widget.rating.note,
                        style: const TextStyle(fontSize: 22),
                      )
                    : Text(
                        "No note",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
