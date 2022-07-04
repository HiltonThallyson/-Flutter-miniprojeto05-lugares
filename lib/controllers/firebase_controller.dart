import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../models/place.dart';

class FirebaseController {
  List<Place> places = [];
  final url = dotenv.get('FIREBASE_URL') + 'places.json';

  Future<void> loadDataFromFirebase() async {
    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    final List<Place> items = [];

    for (var place in data.keys) {
      final Place currentPlace = Place(
          id: place['id'],
          title: place['title'],
          phoneNumber: place['phoneNumber'],
          location: PlaceLocation(
              latitude: place['location']['lat'],
              longitude: place['location']['lng'],
              address: place['location']['address']),
          image: image);
      items.add(currentPlace);
    }

    places = items;
  }

  Future<void> uploadToFirebase(Place place) async {
    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'id': place.id,
          'title': place.title,
          'phoneNumber': place.phoneNumber,
          'location': place.location!.toJson(),
          'imageUrl': place.image.path
        }));
  }
}
