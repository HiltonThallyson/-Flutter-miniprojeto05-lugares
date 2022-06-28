import 'package:f9_recursos_nativos/utils/location_util.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
        appBar: AppBar(title: const Text('Details')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: Image.file(
                        place.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                    child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        color: Colors.black38,
                        child: Text(
                          place.title,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    left: 40,
                    right: 0,
                    bottom: 10,
                  ),
                ]),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Image.network(
                            LocationUtil.generateLocationPreviewImage(
                                latitude: place.location!.latitude,
                                longitude: place.location!.longitude),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          child: Text(
                            place.location!.address,
                            // style: TextStyle(fontSize: 12),
                          ),
                          bottom: 0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            text: 'Telefone: ',
                            children: [
                          TextSpan(
                              text: place.phoneNumber,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal))
                        ])),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
