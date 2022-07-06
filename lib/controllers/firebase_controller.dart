import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../models/place.dart';

class FirebaseController with ChangeNotifier {
  List<Place> _places = [];
  final url = dotenv.get('FIREBASE_URL') + 'places.json';

  List<Place> get places => _places;

  Future<void> loadDataFromFirebase() async {
    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    final List<Place> items = [];
    for (var place in data.values) {
      final Place currentPlace = Place(
        id: place['id'],
        title: place['title'],
        phoneNumber: place['phoneNumber'],
        location: PlaceLocation(
            latitude: place['location']['lat'],
            longitude: place['location']['lgn'],
            address: place['location']['address']),
        image: File(place['imageUrl']),
      );
      items.add(currentPlace);
    }

    _places = items;
    notifyListeners();
  }

  Future<void> uploadToFirebase(Place place) async {
    await http.post(Uri.parse(dotenv.get('FIREBASE_URL') + 'places.json'),
        body: jsonEncode({
          'id': place.id,
          'title': place.title,
          'phoneNumber': place.phoneNumber,
          'location': place.location!.toJson(),
          'imageUrl': place.image.path
        }));
    notifyListeners();
  }
}
