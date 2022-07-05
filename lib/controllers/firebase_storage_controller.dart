import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class FirebaseStorageController {
  Future<void> fetchImageFromStorage(String imageName) async {
    final ref = FirebaseStorage.instance.ref('/images').child('$imageName.jpg');

    final appDocDir = await syspaths.getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.absolute}/images/$imageName.jpg";
    final file = File(filePath);

    ref.writeToFile(file);
  }
}
