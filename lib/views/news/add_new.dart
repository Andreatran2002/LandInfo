// import 'dart:html';
import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../utils/firebase_api.dart';
import '../../utils/storage_service.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final addNewFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  get size => MediaQuery.of(context).size;
  File? file;
  String? fileName;
  final Storage storage = Storage();

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hình ảnh không hợp lệ vui lòng nhập lại!"),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Tải hình ảnh thành công !!"),
        backgroundColor: Colors.green,
      ),
    );
    final path = result.files.single.path!;
    final name = result.files.single.name;

    setState(() => {
          file = File(path),
          fileName = name,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Đăng tin",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Tiêu đề bài viết",
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                ),
                border: OutlineInputBorder(),
              ),
              maxLength: 100,
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: "Nội dung bài viết",
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                ),
                border: OutlineInputBorder(),
              ),
              maxLength: 500,
              minLines: 3,
              maxLines: 7,
              textAlignVertical: TextAlignVertical.top,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 200,
              // decoration: ,
              width: size.width * 0.9,
              child: file != null
                  ? Image.file(file!, fit: BoxFit.cover)
                  : const Center(
                      child: Text('Chọn ảnh'),
                    ),
              // child: ,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                child: const Text(
                  'Tải ảnh lên',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff108A2D),
                  ),
                ),
                onPressed: selectFile,
              ),
            ),
            SizedBox(
              // height: 30,
              width: 90,
              child: ElevatedButton(
                onPressed: () {
                  storage.uploadFile(context, file, fileName!);
                },
                child: const Text(
                  'Đăng',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff108A2D),
                  ),
                ),
                // onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget textField(String textHint, TextInputType inputType, int maxLine,
  //     TextEditingController controller) {
  //   return new text_field.TextField(
  //       textHint: textHint,
  //       inputType: inputType,
  //       maxLine: maxLine,
  //       controller: controller,);
  // }

  // Widget description(String textHint, TextEditingController controller) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
  //     child: TextFormField(
  //       controller: controller,
  //       maxLines: 8,
  //       decoration: const InputDecoration(
  //           contentPadding: EdgeInsets.only(top: 10, bottom: 10)),
  //     ),
  //   );
  // }

  // Widget label(String label) {
  //   return Text(label,
  //       style: const TextStyle(
  //           height: 1.4,
  //           color: Colors.black,
  //           fontWeight: FontWeight.w600,
  //           fontSize: 16.5,
  //           letterSpacing: 0.2));
  // }
}
