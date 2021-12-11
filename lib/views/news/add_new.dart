import 'package:flutter/material.dart';
import 'package:tineviland/Widgets/text_form_field.dart' as text_field;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew>{
final addNewFormKey = GlobalKey<FormState>();
final _titleController  = TextEditingController();
final _contentController = TextEditingController();
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
              child:Form(
                key: addNewFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("Tiêu đề tin tức"),
                    textField("Tiêu đề tin tức",TextInputType.text,1,_titleController),
                    const SizedBox(height: 10),
                    label("Nội dung"),
                    description("Nhập vào nội dung", _contentController),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: ()=>
                      {
                        FirebaseFirestore.instance.collection("news").add({
                        "author_id" :    "AEzSQEo6wIwuSK7ATG0M",
                        "content" :" 222 . quên thêm intl: 0.15.7phụ thuộc vào pubspec.yamltệp của bạn . Phiên bản mới nhất của thư viện có thể được tìm thấy tại đây . — Defuera gói intl có xếp hạng rất thấp — Aseem Bất kỳ ai khác nhận được rằng các thành viên tĩnh không thể được truy cập trong trình khởi tạo? — MrPool @MrPool Có, không thể truy cập vấn đề tương tự với các thành viên tĩnh trong trình khởi tạo. Rất khó chịu vì có ngày tĩnh không có",
                        "date_created": "July 5, 2020 at 12:00:00 AM UTC+7",
                        "date_updated" : "July 5, 2020 at 12:00:00 AM UTC+7",
                        "images": "",
                        "title": "Giá cả thị trường 2020"
                        })
                      },
                      child: const Text('Tiếp tục',
                          style: TextStyle  (
                            height: 1.5,
                            fontSize: 17,
                            color: Colors.white,
                          )),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(8.0),
                        fixedSize: MaterialStateProperty.all(const Size(350,50)),
                        shape: MaterialStateProperty.all(
                          const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          ),
                        ),
                      ),)
                  ],
                ),
              )
          ),
        )
    );
  }

  Widget textField( String textHint, TextInputType inputType,int maxLine , TextEditingController controller){
    return new text_field.TextField(textHint: textHint, inputType: inputType, maxLine: maxLine, controller : controller) ;

  }
  Widget description( String textHint, TextEditingController controller){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: TextFormField(
        controller: controller,
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
