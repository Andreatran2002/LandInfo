import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class phoneAuth extends StatefulWidget {
  const phoneAuth({Key? key}) : super(key: key);

  @override
  _phoneAuthState createState() => _phoneAuthState();
}

class _phoneAuthState extends State<phoneAuth> {
  @override
  final _phonenumberController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Column(children: [
            SizedBox(
              height: 70,
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children : <Widget> [
                  Text("Mã xác thực",
                      style : TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color : Theme.of(context).colorScheme.primary,

                      )),
                  SizedBox(height: 50),
                  textField(),
                  SizedBox(
                    height : 30,
                  )
                ]
              ),
            )

            ,
                optField(),

          ]))),
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
      ),
      child: TextFormField(
        controller: _phonenumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(

            border: InputBorder.none,
            hintText: "Nhập số điện thoại.",
            hintStyle: TextStyle(color: Colors.black12, fontSize: 13),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                child: Text(
                  " (+84) ",
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 17),
                )),
            suffixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: TextButton(
                  child :  Text(" Gửi ",
                      style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),),

                  onPressed:(){
                    if (validNumber(_phonenumberController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Đang gửi mã xác thực', style : TextStyle(color: Colors.white)),backgroundColor: Theme.of(context).colorScheme.primary,),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Số điện thoại không hợp lệ vui lòng nhập lại.'),backgroundColor: Theme.of(context).colorScheme.error,),
                      );
                    }

                  } ,
                )

            )
        ),

      ),

    );
  }
  bool validNumber(String? value){
      if (value == "") {
        return false;
      }
      else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(value!) || value.length > 10)
        return false;

      return true;

  }
  Widget optField() {
    return OTPTextField(
      length: 4,
      width: MediaQuery.of(context).size.width-40,

      fieldWidth: 60,
      style: TextStyle(fontSize: 15,),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);

      },
    );
  }
}
