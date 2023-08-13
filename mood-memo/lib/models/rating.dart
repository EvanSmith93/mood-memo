import 'package:hive/hive.dart';
import 'package:mood_memo/models/rating_value.dart';
import 'package:mood_memo/services/date.dart';

part 'rating.g.dart';

@HiveType(typeId: 4)
class Rating {
  @HiveField(0)
  late DateTime date;
  @HiveField(1)
  late RatingValue value;
  @HiveField(2)
  late String note;

  Rating({required this.date, required this.value, required this.note});

  String getDate() {
    return DateService.formatDate(date);
  }

  String getRelativeDate() {
    return DateService.formatRelativeDate(date);
  }
}
