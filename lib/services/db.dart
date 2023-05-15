import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:intl/intl.dart';

import '../models/rating.dart';

class DatabaseService {
  SharedPreferences? _prefs;

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /*Future<void> createUser(String uid, String name) async {
    await _initPrefs();
    _prefs!.setString('uid', uid);
    _prefs!.setString('name', name);
  }

  Future<String> getUserName() async {
    await _initPrefs();
    final name = _prefs!.getString('name');
    return name ?? 'Not Signed In';
  }*/

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  Future<void> setRating(Rating rating) async {
    await _initPrefs();
    final docKey = formatDate(rating.timestamp);
    _prefs!.setInt('rating_$docKey', rating.number);
    _prefs!.setString('note_$docKey', rating.note);
  }

  Future<Rating?> getRatingFromDay(DateTime day) async {
    await _initPrefs();
    final docKey = formatDate(day);
    final value = _prefs!.getInt('rating_$docKey');
    final note = _prefs!.getString('note_$docKey');
    if (value != null) {
      return Rating(
        timestamp: day,
        value: RatingValue.values[value],
        note: note ?? 'There is no note for this day',
      );
    }
    return null;
  }

  Future<void> deleteRating(String date) async {
    await _initPrefs();
    final docKey = formatDate(DateTime.parse(date));
    _prefs!.remove('rating_$docKey');
    _prefs!.remove('note_$docKey');
  }
}


/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

import '../models/rating.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// https://github.com/furkansarihan/firestore_collection/blob/master/lib/firestore_document.dart
extension FirestoreDocumentExtension on DocumentReference {
  Future<DocumentSnapshot> cacheGet() async {
    try {
      DocumentSnapshot ds = await get(const GetOptions(source: Source.cache));
      if (!ds.exists) {
        return get(const GetOptions(source: Source.server));
      }
      return ds;
    } catch (_) {
      return get(const GetOptions(source: Source.server));
    }
  }
}

// https://github.com/furkansarihan/firestore_collection/blob/master/lib/firestore_query.dart
extension FirestoreQueryExtension on Query {
  Future<QuerySnapshot> cacheGet() async {
    try {
      QuerySnapshot qs = await get(const GetOptions(source: Source.cache));
      if (qs.docs.isEmpty) return get(const GetOptions(source: Source.server));
      return qs;
    } catch (_) {
      return get(const GetOptions(source: Source.server));
    }
  }
}

class DatabaseService {
  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final isSignedIn = FirebaseAuth.instance.currentUser != null;
  User user = FirebaseAuth.instance.currentUser!;

  LocalStorage storage = LocalStorage('user');

  Future createUser(String uid, String name) async {
    if (isSignedIn) {
      await storage.ready;
      storage.setItem('uid', uid);
      storage.setItem('name', name);


      await userCollection.doc(uid).set({
        'name': name,
      });
      bool ratingsExitsts =
          (await userCollection.doc(uid).collection('ratings').limit(1).get())
              .docs
              .isNotEmpty;
      if (!ratingsExitsts) {
        await userCollection.doc(uid).collection('ratings').doc().set({});
      }
    }
  }

  Future<String> getUserName() async {
    return isSignedIn ? await storage.getItem('name') : "Not Signed In";
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  Future setRating(Rating rating) async {
    if (isSignedIn) {
      DocumentReference doc = userCollection
          .doc(user.uid)
          .collection('ratings')
          .doc(rating.getDate());

      await doc.set({
        'value': rating.number,
        'note': rating.note,
      });
    }
  }

  Future<Rating?> getRatingFromDay(DateTime day) async {
    if (isSignedIn) {
      DocumentSnapshot rating = await userCollection
          .doc(user.uid)
          .collection('ratings')
          .doc(formatDate(day))
          .cacheGet();

      if (!rating.exists) {
        return null;
      } else {
        return Rating(
          timestamp: day,
          value: RatingValue.values[int.parse(rating['value'].toString())],
          note: rating['note'],
        );
      }
    } else {
      return null;
    }
  }

  Future deleteRating(String date) async {
    if (isSignedIn) {
      await userCollection
          .doc(user.uid)
          .collection('ratings')
          .doc(date)
          .delete();
    }
  }
}*/