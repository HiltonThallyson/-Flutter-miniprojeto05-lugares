import 'dart:io';

import 'package:f9_recursos_nativos/components/image_input.dart';
import 'package:f9_recursos_nativos/components/location_input.dart';
import 'package:f9_recursos_nativos/models/place.dart';
import 'package:f9_recursos_nativos/provider/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  //deve receber a imagem
  File? _pickedImage;
  PlaceLocation? _location;
  Place? _place;

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  void _setLocation(PlaceLocation? location) {
    _location = location;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _pickedImage == null ||
        _location == null) {
      return;
    }

    Place _newPlace = Place(
        id: '',
        title: _titleController.text,
        phoneNumber: _phoneNumberController.text,
        image: _pickedImage!,
        location: _location);

    Provider.of<GreatPlaces>(context, listen: false).addPlace(_newPlace);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Telefone',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage),
                    const SizedBox(height: 10),
                    LocationInput(_setLocation),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Colors.black,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
