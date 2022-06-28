import 'dart:io';
import 'dart:math';

import 'package:f9_recursos_nativos/models/place.dart';
import 'package:f9_recursos_nativos/utils/db_util.dart';
import 'package:flutter/material.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (item) => Place(
              id: item['id'],
              title: item['title'],
              phoneNumber: item['phoneNumber'],
              image: File(item['image']),
              location: PlaceLocation(
                  latitude: item['latitude'],
                  longitude: item['longitude'],
                  address: item['adress'])),
        )
        .toList();
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(Place place) {
    final newPlace = Place(
        id: Random().nextDouble().toString(),
        title: place.title,
        phoneNumber: place.phoneNumber,
        location: place.location,
        image: place.image);

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'phoneNumber': newPlace.phoneNumber,
      'image': newPlace.image.path,
      'latitude': newPlace.location!.latitude,
      'longitude': newPlace.location!.longitude,
      'adress': newPlace.location!.address,
    });
    notifyListeners();
  }
}
