import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:f9_recursos_nativos/components/image_input.dart';
import 'package:f9_recursos_nativos/components/location_input.dart';
import 'package:f9_recursos_nativos/models/place.dart';
import 'package:f9_recursos_nativos/provider/great_places.dart';

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

    _uploadImage(_pickedImage!);

    _uploadToFirebase(_newPlace);

    Provider.of<GreatPlaces>(context, listen: false).addPlace(_newPlace);

    Navigator.of(context).pop();
  }

  void _uploadImage(File image) {}

  void _uploadToFirebase(Place newPlace) {}

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
                          hintText: 'ex.:55(84)xxxxx-xxxx ou 5584xxxxxxxxx'),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage),
                    const SizedBox(height: 20),
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
