import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:tineviland/Widgets/widget.dart';
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
  final _passwordFocusNode = FocusNode();
  final _repeatpasswordFocusNode = FocusNode();
  bool _isObscurePassword = true;
  bool _isObscureRepeatPassword = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Form(
        key : _forgetPasswordFormKey,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: <Widget> [
          const SizedBox(
            height: 70,
          ),
          Text("Khôi phục tài khoản",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              )),
          const SizedBox(height: 50),
          TextFormField(
            style:  const TextStyle(
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
                        _isObscureRepeatPassword = !_isObscureRepeatPassword;
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
              const SizedBox(height : 30),
              ElevatedButton(

                child: const Text('Khôi phục' ,
                    style:TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    )

                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8.0),
                  shape: MaterialStateProperty.all(
                    const BeveledRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(3.0)),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_forgetPasswordFormKey.currentState!.validate()) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const phoneAuth()),
                    // );
                  }
                },
              )
        ]),
      ),
    );
  }
}
