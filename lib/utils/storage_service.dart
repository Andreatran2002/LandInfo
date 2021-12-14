import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';

class Storage {
  final storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
    BuildContext context,
    File? file,
    String fileName,
  ) async {
    try {
      print("oke oke " + fileName);
      await storage
          .ref('images/$fileName')
          .putFile(file!)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Upload ảnh thành công",
                  ),
                  backgroundColor: Colors.green,
                ),
              ));
    } on firebase_core.FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
      print(e);
    }
  }
}
