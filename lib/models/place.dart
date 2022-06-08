import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? addressName;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.addressName,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Place({
    required this.id,
    required this.title,
    this.location,
    required this.image,
  });
}
