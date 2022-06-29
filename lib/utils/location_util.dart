import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final GOOGLE_API_KEY = dotenv.get("GOOGLE_API_KEY");

class LocationUtil {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    //https://developers.google.com/maps/documentation/maps-static/overview
    //https://pub.dev/packages/google_maps_flutter
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static String generateAddressFromLatLong({
    double? latitude,
    double? longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&location_type=ROOFTOP&result_type=street_address&key=$GOOGLE_API_KEY';
  }

  static Future<String?> getGenetaredAddress(String url) async {
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    final address = data['results'][0]['formatted_address'];
    return address;
  }
}
