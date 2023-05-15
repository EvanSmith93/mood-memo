/*import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:mood_log/models/rating.dart';
import 'dart:developer';

import 'package:mood_log/services/auth.dart';

class LocalStorageService {
  static LocalStorage storage = LocalStorage('user');

  void setCreatedAt() async {
    await storage.ready;
    storage.setItem('createdAt', DateTime.now());
  }

  Future<bool> isStillValid() async {
    await storage.ready;
    // if there's no createdAt, return false
    if (storage.getItem('createdAt') != null) {
      DateTime createdAt = storage.getItem('createdAt');

      if (DateTime.now().difference(createdAt).inMinutes > 1) {
        clearRatings();
        setCreatedAt();
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  void createUser(String uid, String name) async {
    await storage.ready;
    storage.setItem('uid', uid);
    storage.setItem('name', name);
    storage.setItem('ratings', []);
    setCreatedAt();
  }

  Future<String> getUserName() async {
    await storage.ready;
    return storage.getItem('name');
  }

  void setRating(Rating rating) async {
    await storage.ready;
    // if the list of today's ratings is not empty, delete the last rating
    //Rating? otherRating =
    //    await getRatingFromDay(rating.timestamp ?? DateTime.now());
    //if (otherRating != null) {
    //  deleteRating(otherRating);
    //}
    List ratings = await getRatings();
    ratings.add(jsonEncode(rating.toJson()));
    storage.setItem('ratings', jsonEncode(rating.toJson()));
  }

  void setRatings(List ratings) async {
    await storage.ready;
    storage.setItem('ratings', jsonEncode(ratings));
  }

  Future<List> getRatings() async {
    await storage.ready;
    print(storage.getItem('ratings'));
    String ratings = storage.getItem('ratings');
    // convert ratings to a json object
    //print(.timestamp.runtimeType);

    //List ratingsList = json.decode(ratings);
    return [Rating.fromJson(json.decoder.convert(ratings))];
  }

  Future<Rating?> getRatingFromDay(DateTime day) async {
    await storage.ready;
    List ratings = await getRatings();
    for (var rating in ratings) {
      if (rating.timestamp.day == day.day) {
        return rating;
      }
    }
    return null;
  }

  void deleteRating(Rating rating) async {
    await storage.ready;
    List ratings = await getRatings();
    ratings.removeWhere(
        (r) => (r.timestamp == rating.timestamp && r.value == rating.value));
    storage.setItem('ratings', ratings);
  }

  void clear() async {
    await storage.ready;
    storage.clear();
  }

  void clearRatings() async {
    await storage.ready;
    storage.setItem('ratings', []);
  }
}
*/