import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/models/post_repository.dart';
class AddPost extends StatefulWidget {
  const AddPost({this.category = Category.all  , Key? key}) : super(key: key);
  final Category category;
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Category dropdownvalue = Category.all;
  final List<Category> _categories = Category.values;
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Đăng tin", style: TextStyle(
          color : Colors.white,),
        ),
      ),
      body : Container(
        padding: EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label("Tiêu đề bài đăng"),
              textField("Tiêu đề bài đăng",TextInputType.text),
              SizedBox(height: 10),
              label("Hình thức"),
              DropdownButton(
                isExpanded: true,
                value: dropdownvalue,
                icon: Icon(Icons.keyboard_arrow_down),
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
              SizedBox(height: 10),
              label("Giá cả"),
              textField("Nhập giá", TextInputType.number),
              SizedBox(height: 10),
              label("Diện tích (m2)"),
              textField("Nhập diện tích", TextInputType.number),
              SizedBox(height: 10),
              label("Nội dung"),
              textField("Nhập giá (VNĐ)", TextInputType.number),
            ],
          )
        ),
      )
    );
  }
  Widget chipData(){
    return Chip(label : Text("Không được để trống" ,style : TextStyle(
      color : Theme.of(context).colorScheme.error,
    )));
  }
  Widget textField( String textHint, TextInputType inputType){
    return Container(
      height : 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: TextFormField(
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: textHint,
          hintStyle: TextStyle(
            color : Colors.black12,
            fontSize: 12
          ),
          contentPadding: EdgeInsets.only(left : 20,right : 20)
        ),
      ),
    );
  }

  Widget label(String label){
    return Text(
      label,
      style : TextStyle(
        height: 1.4,
          color : Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16.5,
        letterSpacing: 0.2
      )
    );
  }

}
