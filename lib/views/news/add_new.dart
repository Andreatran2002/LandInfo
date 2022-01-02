import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:tineviland/Widgets/rich_editor.dart';
import 'package:tineviland/blocs/user_bloc.dart';

import '../../utils/firebase_api.dart';
import '../../utils/storage_service.dart';
import '../home.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final addNewFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final contentController = TextEditingController();
  get size => MediaQuery.of(context).size;
  File? file;
  String? fileName;
  String? fileUrl;
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

  // final _textQuill = quill.QuillController.basic();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserBloc>(context);
    RichEditor richEditor = RichEditor(controller: contentController);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(
            children: <Widget>[
              Container(child: Row(
                  children : [label("Tiêu đề bài viết")])),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                  border: OutlineInputBorder(),
                ),
                maxLength: 100,
              ),
              Container(child: Row(
                  children : [label("Nội dung")])),
              richEditor,
              Container(
                  child: Row(
                    children: [
                      label("Ảnh minh họa"),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () => {selectFile()},
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 200,
                width: size.width * 0.9,
                child: file != null
                    ? Image.file(file!, fit: BoxFit.cover)
                    : const Center(
                        child: Text('Chọn ảnh'),
                      ),
                // child: ,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Vui lòng nhập tiêu đề!"),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ));
                    } else if (richEditor.controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Vui lòng nhập Nội dung!"),
                          backgroundColor: Theme.of(context).colorScheme.error));
                    } else {
                      String url = await storage.uploadFile(
                        context,
                        file,
                        fileName!,
                        fileUrl,
                      );
                      if (url.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Đã có lỗi khi tải ảnh lên !!"),
                        ));
                      } else {
                        try {
                          await FirebaseFirestore.instance
                              .collection("news")
                              .add({
                            "author_id": user.currentUser,
                            "content": richEditor.controller.text,
                            "title": _titleController.text,
                            "images": url,
                            "date_created": new DateTime.now(),
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                                  (route) => false);
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: const Text("Đăng bài thành công"),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        } on FirebaseException catch (e) {
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
                      const Color(0xff108A2D),
                    ),
                  ),
                  // onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget label(String label) {
    return Text(label,
        textAlign: TextAlign.left,
        style: const TextStyle(

            height: 1.4,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.5,
            fontFamily: 'Montserrat',
            letterSpacing: 0.2));
  }

}
