import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:tineviland/Widgets/widget.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'package:tineviland/views/auth/phoneauth.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  final _forgetPasswordFormKey = GlobalKey<FormState>();
  final _unfocusedColor = Colors.grey[600];
  final _passwordController = TextEditingController();
  final _repeatpasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _repeatpasswordFocusNode = FocusNode();
  bool _isObscurePassword = true;
  var authService = AuthMethods();
  bool _isObscureRepeatPassword = true;
  var verificationId ;
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Form(
        key: _forgetPasswordFormKey,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
              Text("Quên mật khẩu",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              const SizedBox(height: 50),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Số điện thoại",
                    labelStyle: TextStyle(
                      color: _phoneFocusNode.hasFocus
                          ? Theme.of(context).colorScheme.secondary
                          : _unfocusedColor,
                    )),
                focusNode: _phoneFocusNode,
                validator: (value) {
                  if(validNumber(value)){
                    return null;
                  }
                  else return "Số điện thoại không hợp lệ";
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: "Mật khẩu mới",
                    suffixIcon: IconButton(
                        icon: Icon(_isObscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscurePassword = !_isObscurePassword;
                          });
                        }),
                    labelStyle: TextStyle(
                      color: _passwordFocusNode.hasFocus
                          ? Theme.of(context).colorScheme.secondary
                          : _unfocusedColor,
                    )),
                focusNode: _passwordFocusNode,
                validator: (value) {
                  if (value == "") {
                    return 'Vui lòng không được bỏ trống mật khẩu';
                  } else {
                    if (value!.length < 8) {
                      return 'Vui lòng nhập mật khẩu dài ít nhất 8 kí tự  ';
                    } else {
                      return null;
                    }
                  }
                },
                obscureText: _isObscurePassword,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: _repeatpasswordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: "Nhập lại mật khẩu mới",
                    suffixIcon: IconButton(
                        icon: Icon(_isObscureRepeatPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscureRepeatPassword =
                                !_isObscureRepeatPassword;
                          });
                        }),
                    labelStyle: TextStyle(
                      color: _repeatpasswordFocusNode.hasFocus
                          ? Theme.of(context).colorScheme.secondary
                          : _unfocusedColor,
                    )),
                focusNode: _repeatpasswordFocusNode,
                validator: (value) {
                  if (value == "") {
                    return 'Vui lòng không được bỏ trống mật khẩu';
                  }
                  if (value != _passwordController.text) {
                    return "Mật khẩu nhập lại không khớp.";
                  }
                  return null;
                },
                obscureText: _isObscureRepeatPassword,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text('Khôi phục',
                    style: TextStyle(
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
                ),
                onPressed: () async{
                  if (_forgetPasswordFormKey.currentState!.validate()) {
                    String phone = _phoneController.text;
                    phone.substring(1);
                    phone ="+84"+phone;
                    var bool = await authService.hasAccount(_phoneController.text);
                    print(bool);
                    if (bool){

                    await auth.verifyPhoneNumber(
                      phoneNumber: phone,
                      verificationCompleted: (PhoneAuthCredential credential) async {
                        // await auth.signInWithCredential(credential);
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        if (e.code == 'invalid-phone-number') {
                          print('The provided phone number is not valid.');
                        }
                      },
                      codeSent: (String verificationId, int? resendToken) async {
                        this.verificationId = verificationId;
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                      },
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Đang gửi mã xác thực', style : TextStyle(color: Colors.white)),backgroundColor: Theme.of(context).colorScheme.primary,),
                    );
                    showInformationDialog(context);
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Tài khoản không tồn tại!', style : TextStyle(color: Colors.white)),backgroundColor: Theme.of(context).colorScheme.error)
                      );
                }
                  }
                },
              )
            ]),
      ),
    );
  }
  Future<void> showInformationDialog(BuildContext context) async {

    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width-120,
                fieldWidth: 30,
                style: const TextStyle(fontSize: 15,),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin)  {
                  authService.authenticationByPhone(verificationId, pin, _phoneController.text, context);

                },
              ),
              actions: <Widget>[
                InkWell(
                  child: const Text('Đóng',
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }
  bool validNumber(String? value){
    if (value == "") {
      return false;
    }
    else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(value!) || value.length > 10)
      return false;

    return true;

  }
}
