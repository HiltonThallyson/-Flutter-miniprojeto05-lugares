import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {'lat': latitude, 'lgn': longitude, 'address': address};
  }
}

class Place {
  String id;
  final String title;
  final String phoneNumber;
  final PlaceLocation? location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.phoneNumber,
    required this.location,
    required this.image,
  });
}
