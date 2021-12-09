import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/models/post_repository.dart';
import 'package:tineviland/Widgets/text_form_field.dart' as text_field;
import 'package:tineviland/views/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AddPost extends StatefulWidget {
  const AddPost({this.category = Category.all  , Key? key}) : super(key: key);
  final Category category;
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(10.856809388642066, 106.77465589400319);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Category dropdownvalue = Category.all;
  final List<Category> _categories = Category.values;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Đăng tin", style: TextStyle(
          color : Colors.white,),
        ),
      ),
      body : Container(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label("Tiêu đề bài đăng"),
              textField("Tiêu đề bài đăng",TextInputType.text,1),
              const SizedBox(height: 10),
              label("Hình thức"),
              DropdownButton(
                isExpanded: true,
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items:_categories.map((Category items) {
                  return DropdownMenuItem(
                      value: items,
                      child: Text(PostsRepository.printCategory(items))
                  );
                }
                ).toList(),
                onChanged: (Category? newValue){
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
              const SizedBox(height: 10),
              label("Giá cả"),
              textField("Nhập giá", TextInputType.number,1),
              const SizedBox(height: 10),
              label("Diện tích (m2)"),
              textField("Nhập diện tích", TextInputType.number,1),
              const SizedBox(height: 10),
              label("Nội dung"),
              description("Nhập vào nội dung"),
              const SizedBox(height: 10),
              label("Địa chỉ"),
              Container(
                height : 200,
                child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10,
                )),
              ),
              ElevatedButton(
                  onPressed: ()=>
                  {
                  Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (builder)=> const Map()),
                  (route) => false)
                  },
                  child: const Text('Tiếp tục',
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 17,
                        color: Colors.white,
                      )),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8.0),
                  shape: MaterialStateProperty.all(
                    const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    ),
                  ),
                ),)
            ],
          )
        ),
      )
    );
  }

  Widget textField( String textHint, TextInputType inputType,int maxLine){
    return new text_field.TextField(textHint: textHint, inputType: inputType, maxLine: maxLine) ;

  }
  Widget description( String textHint){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: TextFormField(
        maxLines: 8,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.only( top: 10, bottom: 10)
        ),
      ),
    );
  }
  Widget label(String label){
    return Text(
      label,
      style : const TextStyle(
        height: 1.4,
          color : Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16.5,
        letterSpacing: 0.2
      )
    );
  }

}
