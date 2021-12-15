import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';

class Storage {
  final storage = firebase_storage.FirebaseStorage.instance;

  Future<String> uploadFile(
    BuildContext context,
    File? file,
    String fileName,
    String? fileUrl,
  ) async {
    String url;
    try {
      print('zoooooooo');
      var uploadTask = await storage.ref('images/$fileName').putFile(file!);
      var dowurl = await uploadTask.ref.getDownloadURL();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //       "Upload ảnh thành công",
      //     ),
      //     backgroundColor: Colors.green,
      //   ),
      // );
      url = dowurl.toString();
      return url;
    } on firebase_core.FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
      print(e);
      return '';
    }
  }
}
