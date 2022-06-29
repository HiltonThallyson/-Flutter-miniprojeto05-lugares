import 'package:flutter/material.dart';

import 'package:f9_recursos_nativos/utils/location_util.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
        appBar: AppBar(title: const Text('Detalhes do lugar')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(children: [
                  Container(
                      width: screenWidth,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Wrap(
                          children: [
                            Container(
                              width: screenWidth * 0.9,
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      text: 'Endereço: ',
                                      children: [
                                    TextSpan(
                                        text: place.location!.address,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal))
                                  ])),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const Text(
                          'Telefone: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              launchUrl(Uri.parse('tel:+${place.phoneNumber}'));
                            },
                            child: Text(place.phoneNumber,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal))),
                      ],
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                height: screenHeight * 0.32,
                child: Image.network(
                  LocationUtil.generateLocationPreviewImage(
                      latitude: place.location!.latitude,
                      longitude: place.location!.longitude),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ));
  }
}
