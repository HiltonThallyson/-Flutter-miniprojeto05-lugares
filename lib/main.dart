import 'dart:io';

import 'package:f9_recursos_nativos/controllers/firebase_controller.dart';
import 'package:f9_recursos_nativos/provider/great_places.dart';
import 'package:f9_recursos_nativos/screens/address_form_screen.dart';
import 'package:f9_recursos_nativos/screens/place_detail_screen.dart';
import 'package:f9_recursos_nativos/screens/place_form_screen.dart';
import 'package:f9_recursos_nativos/screens/places_list_screen.dart';
import 'package:f9_recursos_nativos/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(mergeWith: Platform.environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GreatPlaces()),
        ChangeNotifierProvider(create: (context) => FirebaseController()),
      ],
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData().copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.indigo,
                  secondary: Colors.amber,
                )),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL: (context) => PlaceDetailScreen(),
          AppRoutes.ADDR_FORM: (context) => AddressFormScreen(),
        },
      ),
    );
  }
}
