import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/Views/map.dart';
import 'package:tineviland/blocs/application_bloc.dart';
import 'package:tineviland/blocs/user_bloc.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/models/post_repository.dart';
import 'package:tineviland/Widgets/text_form_field.dart' as text_field;
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
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(10.856809388642066, 106.77465589400319);
  final _addPostFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _contentController = TextEditingController();
  final _surfaceAreaController = TextEditingController();
  String Address = "Chưa cập nhập vị trí";
  bool circular = false;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng? pos;
  void onDataChange(val) {
    setState(() {
      pos = val;
      // Address = val.toString();
      print(pos);
      print("mêmmeeeeeeeeeeee");
    });
    GetAddressFromLatLong(val);
  }

  @override
  Category dropdownvalue = Category.all;
  final List<Category> _categories = Category.values;
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Đăng tin",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
              child: Form(
            key: _addPostFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Tiêu đề bài đăng"),
                textField("Tiêu đề bài đăng", TextInputType.text, 1,
                    _titleController),
                const SizedBox(height: 10),
                label("Hình thức"),
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
                label("Giá cả"),
                textField(
                    "Nhập giá", TextInputType.number, 1, _priceController),
                const SizedBox(height: 10),
                label("Diện tích (m2)"),
                textField("Nhập diện tích", TextInputType.number, 1,
                    _surfaceAreaController),
                const SizedBox(height: 10),
                Container(
                    child: Row(
                  children: [
                    label("Vị trí"),
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
                label("Nội dung"),
                description("Nhập vào nội dung", _contentController),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      circular = true;
                    });

                    try {
                      if (_addPostFormKey.currentState!.validate()) {
                        setState(() {
                          circular = false;
                        });
                        var post = await FirebaseFirestore.instance.collection("posts").add({
                          "category" : dropdownvalue.index,
                          "author_id" : userBloc.currentUser,
                          "content" : _contentController.text,
                          "date_created": DateTime.now(),
                          "date_updated" : DateTime.now(),
                          "images": [],
                          "title": _titleController.text,
                          "locate": GeoPoint(pos!.latitude, pos!.longitude),
                          "price": _priceController.text,
                          "surfaceArea": _surfaceAreaController.text
                        });
                        print(post);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                                (route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã tạo bài đăng thành công!")));
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
                      : const Text('Đăng',
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
            ),
          )),
        ));
  }

  Widget textField(String textHint, TextInputType inputType, int maxLine,
      TextEditingController controller) {
    return  text_field.TextField(
        textHint: textHint,
        inputType: inputType,
        maxLine: maxLine,
        controller: controller);
  }

  Widget description(String textHint, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: TextFormField(
        controller: controller,
        maxLines: 8,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 10, bottom: 10)),
        validator: (value) {
          if (value == "") {
            return 'Vui lòng không được bỏ trống';
          }
          return null;
        },
      ),
    );
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
    print("Địa chỉ đây nè -----------------------------------------------");
  }
  Future<void> updateUser(String userDoc,String postDoc) async {

    // await FirebaseFirestore.instance.collection("users").doc(userDoc).get().then((value) => )
    // oldPost = [... oldPost, postDoc]

  }
}
