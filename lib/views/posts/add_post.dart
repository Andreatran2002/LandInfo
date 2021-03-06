import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geocoding/geocoding.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/Views/map.dart';
import 'package:tineviland/Widgets/rich_editor.dart';
import 'package:tineviland/blocs/application_bloc.dart';
import 'package:tineviland/blocs/user_bloc.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/models/post_repository.dart';
import 'package:tineviland/Widgets/text_form_field.dart' as text_field;
import 'package:tineviland/utils/storage_service.dart';
import 'package:tineviland/views/map.dart' as MyMap;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../home.dart';

class AddPost extends StatefulWidget {
  const AddPost({this.category = Category.all, Key? key}) : super(key: key);
  final Category category;
  // final MyMap.Map map ;
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String _description = '';
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(10.856809388642066, 106.77465589400319);
  final addPostFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final contentController = TextEditingController();
  final _surfaceAreaController = TextEditingController();
  get size => MediaQuery.of(context).size;
  File? file;
  String? fileName;
  String? fileUrl;
  final Storage storage = Storage();
  @override
  void initState() {
    super.initState();

    contentController.addListener(() {
      print(contentController.text);
    });
  }
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("H??nh ???nh kh??ng h???p l??? vui l??ng nh???p l???i!"),
        ),
      );
      return;
    }
    print("he1");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("T???i h??nh ???nh th??nh c??ng !!"),
        backgroundColor: Colors.green,
      ),
    );
    final path = result.files.single.path!;
    final name = result.files.single.name;

    setState(() => {
          file = File(path),
          fileName = name,
        });
    print(path +" "+ name );
  }

  String Address = "Ch??a c???p nh???p v??? tr??";
  bool circular = false;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  late RichEditor richEditor;
  LatLng? pos;
  void onDataChange(val) {
    setState(() {
      pos = val;
    });
    GetAddressFromLatLong(val);
  }


  Category dropdownvalue = Category.all;
  final List<Category> _categories = Category.values;

  @override
  Widget build(BuildContext context) {
    richEditor = RichEditor(controller: contentController , key:addPostFormKey);
    final userBloc = Provider.of<UserBloc>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "????ng tin",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFieldDefault(_titleController, "Ti??u ????? b??i ????ng", 2, 3,TextInputType.text),

                  label("H??nh th???c"),
                  DropdownButton(
                    isExpanded: true,
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: _categories.map((Category items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(PostsRepository.printCategory(items)));
                    }).toList(),
                    onChanged: (Category? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  textFieldDefault(_priceController, "Gi?? c??? (tri???u)", 1, 1,TextInputType.number),
                  textFieldDefault(_surfaceAreaController, "Di???n t??ch (m2)", 1, 1,TextInputType.number),
                  Container(
                      child: Row(
                        children: [
                          label("V??? tr??"),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyMap.Map(
                                        pos: pos,
                                        callback: (val) => onDataChange(val),
                                      )))
                            },
                          )
                        ],
                      )),
                  Text(Address),
                  const SizedBox(height: 10),
                  label("N???i dung"),
                  richEditor,
                  Container(
                      child: Row(
                        children: [
                          label("???nh minh h???a"),
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
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 200,
                    // decoration: ,
                    width: size.width * 0.9,
                    child: file != null
                        ? Image.file(file!, fit: BoxFit.cover)
                        : const Center(
                      child: Text('Ch???n ???nh'),
                    ),
                    // child: ,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        circular = true;
                      });

                      try {
                        if (pos == null) {
                          SnackBarError("Vui l??ng ????nh d???u v??? tr?? !!", context);
                        }
                        if (dropdownvalue == Category.all) {
                          SnackBarError("Vui l??ng th??m h??nh th???c !!", context);
                        }
                        if (_titleController.text == "") {
                          SnackBarError("Vui l??ng nh???p ti??u ????? !!", context);
                        }
                        if (_priceController.text == "") {
                          SnackBarError("Vui l??ng nh???p gi?? ti???n !!", context);
                        }
                        if (_surfaceAreaController.text == "") {
                          SnackBarError("Vui l??ng nh???p gi?? ti???n !!", context);
                        }
                        if(richEditor.controller.text==""){
                          SnackBarError("Vui l??ng nh???p n???i dung chi ti???t !!", context);
                        }

                        if (pos != null &&
                            dropdownvalue != Category.all &&
                            _titleController != "" &&
                        _surfaceAreaController!="" &&
                        _priceController != ""&&
                            richEditor.controller.text != ""
                        ) {
                          print("he2");
                          String url = await storage.uploadFile(
                            context,
                            file,
                            fileName!,
                            fileUrl,
                          );
                          if (url.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("???? c?? l???i khi t???i ???nh l??n !!"),
                            ));
                          } else {
                            setState(() {
                              circular = false;
                            });
                            print("he");
                            var post = await FirebaseFirestore.instance
                                .collection("posts")
                                .add({
                              "category": dropdownvalue.index,
                              "author_id": userBloc.currentUser,
                              "content": richEditor.controller.text,
                              "date_created": DateTime.now(),
                              "date_updated": DateTime.now(),
                              "images": url,
                              "title": _titleController.text,
                              "locate": GeoPoint(pos!.latitude, pos!.longitude),
                              "price": int.parse(_priceController.text),
                              "surfaceArea":
                              int.parse(_surfaceAreaController.text)
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                    (route) => false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor:
                                Theme.of(context).colorScheme.primary,
                                content: const Text("???? t???o b??i ????ng th??nh c??ng!")));
                          }
                        }
                      } catch (e) {
                        final snackbar = SnackBar(content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        setState(() {
                          circular = false;
                        });
                      }
                    },
                    child: circular
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text('????ng',
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 17,
                          color: Colors.white,
                        )),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(8.0),
                      fixedSize: MaterialStateProperty.all(const Size(350, 50)),
                      shape: MaterialStateProperty.all(
                        const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ));
  }

  Widget textField(String textHint, TextInputType inputType, int maxLine,
      TextEditingController controller) {
    return text_field.TextField(
        textHint: textHint,
        inputType: inputType,
        maxLine: maxLine,
        controller: controller);
  }

  Widget label(String label) {
    return Text(label,
        style: const TextStyle(
            height: 1.4,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.5,
            letterSpacing: 0.2));
  }

  void GetAddressFromLatLong(LatLng position) async {
    setState(() async {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];

      Address =
          '${place.street} ${place.subAdministrativeArea} ${place.locality} ${place.administrativeArea} ${place.country}';
    });
    print(Address);
    print("?????a ch??? ????y n?? -----------------------------------------------");
  }

  Future<void> updateUser(String userDoc, String postDoc) async {
    // await FirebaseFirestore.instance.collection("users").doc(userDoc).get().then((value) => )
    // oldPost = [... oldPost, postDoc]
  }
  void SnackBarError(String content,BuildContext context ){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text( content),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }
  Widget textFieldDefault(TextEditingController controller, String? labelText , int minLines , int maxLines,  TextInputType inputType){
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        labelText: labelText,

        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
        ),
        border: const OutlineInputBorder(),
      ),
      keyboardType: inputType,
      maxLength: 500,
      minLines: minLines,
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.top,
    );
  }
}
