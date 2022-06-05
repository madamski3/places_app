import 'dart:io';
import 'package:flutter/material.dart';
import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace({required String title, required File image}) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
