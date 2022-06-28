import 'package:f9_recursos_nativos/models/place.dart';
import 'package:f9_recursos_nativos/screens/map_screen.dart';
import 'package:f9_recursos_nativos/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function setLocation;

  LocationInput(this.setLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  PlaceLocation? _placeLocation;
  String? _addressUrl;
  String? _currentAddress;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    setAddressBasedOnLatLong(locData.latitude!, locData.longitude!);

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
          fullscreenDialog: true, builder: ((context) => MapScreen())),
    );

    if (selectedPosition == null) return;

    setAddressBasedOnLatLong(
        selectedPosition.latitude, selectedPosition.longitude);

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: selectedPosition.latitude,
        longitude: selectedPosition.longitude);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  String getAddressUrl(double latitude, double longitude) {
    return LocationUtil.generateAddressFromLatLong(
        latitude: latitude, longitude: longitude);
  }

  void setAddressBasedOnLatLong(double latitude, double longitude) {
    _addressUrl = getAddressUrl(latitude, longitude);
    LocationUtil.getGenetaredAddress(_addressUrl!).then((adress) {
      setState(() {
        _currentAddress = adress;
      });
    }).then((_) {
      _placeLocation = PlaceLocation(
          latitude: latitude, longitude: longitude, address: _currentAddress!);
      widget.setLocation(_placeLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text('Localização não informada!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Localização atual'),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Selecione no Mapa'),
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}
