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
              widget.controller.editRating(context, widget.refresher, widget.rating);
            }, 
            icon: const Icon(Icons.edit)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rating: ",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)
            ),
            Text(
              "${widget.rating.value.number} out of 5", 
              style: const TextStyle(fontSize: 24)
            ),
            const SizedBox(height: 20),
            const Text(
              "Note: ",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)
            ),
            Text(
              widget.rating.note, 
              style: const TextStyle(fontSize: 24)
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Rating"),
                        content: const Text("Are you sure you want to delete this rating?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, 
                            child: const Text("Cancel")
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              widget.controller.deleteRating(widget.rating.getDate(), widget.refresher);
                              Navigator.pop(context);
                            }, 
                            child: const Text("Delete")
                          ),
                        ],
                      );
                    }
                  );
                }, 
                icon: const Icon(Icons.delete), 
                label: const Text("Delete"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}