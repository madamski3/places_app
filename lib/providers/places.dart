import 'dart:io';
import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace({
    required String title,
    required File image,
    required PlaceLocation location,
  }) async {
    final address = await LocationHelper.getPlaceAddress(
      location.latitude,
      location.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    await DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image_path': newPlace.image.path,
      'latitude': newPlace.location!.latitude,
      'longitude': newPlace.location!.longitude,
      'address': newPlace.location!.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData('places');
    final transformedData = data
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image_path']),
              location: PlaceLocation(
                latitude: item['latitude'],
                longitude: item['longitude'],
                address: item['address'],
              ),
            ))
        .toList();
    _items = transformedData;
    notifyListeners();
  }

  Place findById(String id) {
    final foundPlace = _items.firstWhere((place) => place.id == id);
    return foundPlace;
  }
}
