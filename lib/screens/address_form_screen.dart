import 'package:f9_recursos_nativos/utils/location_util.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../models/place.dart';

class AddressFormScreen extends StatelessWidget {
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _streetController = TextEditingController();
  final _houseNumberController = TextEditingController();

  Future<PlaceLocation?>? _generateCoordinatesFromAddress() {
    if (_countryController.text.isEmpty ||
        _stateController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _districtController.text.isEmpty ||
        _streetController.text.isEmpty ||
        _houseNumberController.text.isEmpty) {
      return null;
    }

    String _address =
        '${_countryController.text},${_stateController.text},${_cityController.text},${_districtController.text},${_streetController.text},${_houseNumberController.text}';

    return LocationUtil.getGeneratedLocationFromAddress(_address);
  }

  void _submitForm(BuildContext context) async {
    final location = await _generateCoordinatesFromAddress();
    if (location != null) {
      Navigator.pop(context, location);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Endereço inválido!'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar endereço'),
        actions: [
          IconButton(
              onPressed: () => _submitForm(context),
              icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: _countryController,
            decoration: const InputDecoration(labelText: 'País'),
          ),
          TextField(
            controller: _stateController,
            decoration: const InputDecoration(labelText: 'Estado'),
          ),
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
          TextField(
            controller: _districtController,
            decoration: const InputDecoration(labelText: 'Bairro'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: TextField(
                  controller: _streetController,
                  decoration: const InputDecoration(
                      labelText: 'Rua',
                      constraints: BoxConstraints(maxWidth: 250)),
                ),
              ),
              Flexible(
                flex: 1,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _houseNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Número',
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () => _submitForm(context),
        child: const Text('Confirmar'),
      ),
    );
  }
}
