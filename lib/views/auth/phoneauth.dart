import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:tineviland/models/user.dart' as user_account;
import 'package:tineviland/utils/authmethod.dart';

enum MobileVerificationState{
  SHOW_MOBILE_FORM_STATE,
  SHOW_OPT_FORM_STATE
}


class phoneAuth extends StatefulWidget {
  final user_account.User _account ;
  const phoneAuth( {required user_account.User account }) : _account = account ;

  @override
  _phoneAuthState createState() => _phoneAuthState();
}

class _phoneAuthState extends State<phoneAuth> {

  @override
  var authService = AuthMethods();
  var currenState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  var verificationId ;
  final _phonenumberController = TextEditingController();
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;


  Widget build(BuildContext context) {
     return Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Column(children: [
            const SizedBox(
              height: 40,
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
                  const SizedBox(height: 50),
                  textField(),
                  const SizedBox(
                    height : 30,
                  )
                ]
              )
            )
            ,optField(),
          ])));
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
            hintText: "(+84)",
            hintStyle: const TextStyle(color: Colors.black12, fontSize: 12),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 19, horizontal: 20),

            suffixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextButton(
                  child :  Text(" Gửi ",
                      style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),),

                  onPressed:() async {
                    String phone = _phonenumberController.text;
                    phone.substring(1);
                    phone ="+84"+phone;
                    if (validNumber(_phonenumberController.text)) {
                      await auth.verifyPhoneNumber(
                        phoneNumber: phone,
                        verificationCompleted: (PhoneAuthCredential credential) async {
                          // await auth.signInWithCredential(credential); 
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            print('The provided phone number is not valid.');
                          }

                          // Handle other errors
                        },
                        codeSent: (String verificationId, int? resendToken) async {
                          setState(()=> {currenState = MobileVerificationState.SHOW_OPT_FORM_STATE});
                          // Update the UI - wait for the user to enter the SMS code
                          this.verificationId = verificationId;

                          // Create a PhoneAuthCredential with the code

                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          // Auto-resolution timed out...
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: const Text('Đang gửi mã xác thực', style : TextStyle(color: Colors.white)),backgroundColor: Theme.of(context).colorScheme.primary,),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Số điện thoại không hợp lệ vui lòng nhập lại.'),backgroundColor: Theme.of(context).colorScheme.error,),
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
    if (currenState == MobileVerificationState.SHOW_MOBILE_FORM_STATE)
      return const Text("*Vui lòng nhập số điện thoại để nhận mã xác thực!", style : TextStyle(fontSize : 14, fontStyle: FontStyle.italic, color : Colors.black54));
    else {
      return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width-120,
      fieldWidth: 30,
      style: const TextStyle(fontSize: 15,),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin)  {
        authService.signUpWithPhoneNumber(verificationId, pin, context,widget._account, _phonenumberController.text);
      },
    );
    }
  }

  
}
