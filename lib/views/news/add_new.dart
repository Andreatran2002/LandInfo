// import 'dart:html';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../utils/firebase_api.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final addNewFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  File? file;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? file!.path : 'Name of file!';
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
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
              child: Text(fileName),
              // child: ,
            ),
            SizedBox(
              width: 300,
              child: TextButton(
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
              child: TextButton(
                onPressed: () {
                  print('up');
                  if (file == null) return;
                  final fileName = file!.path;
                  final destination = 'files/$fileName';

                  FirebaseApi.uploadFile(destination, file!);
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
