import 'dart:io';

import 'package:f9_recursos_nativos/controllers/firebase_controller.dart';
import 'package:f9_recursos_nativos/provider/great_places.dart';
import 'package:f9_recursos_nativos/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<FirebaseController>(context, listen: false)
            .loadDataFromFirebase(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<FirebaseController>(
                child: const Center(
                  child: Text('Nenhum local'),
                ),
                builder: (context, greatPlaces, child) => greatPlaces
                        .places.isEmpty
                    ? child!
                    : ListView.builder(
                        itemCount: greatPlaces.places.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                                greatPlaces.places.elementAt(index).image),
                          ),
                          title:
                              Text(greatPlaces.places.elementAt(index).title),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.PLACE_DETAIL,
                                arguments: greatPlaces.places.elementAt(index));
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
