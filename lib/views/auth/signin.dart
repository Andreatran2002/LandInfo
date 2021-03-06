import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tineviland/Widgets/widget.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'signup.dart';
import '../auth/forgetpassword.dart';
import '../home.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() {
      setState(() {
        //Redraw so that the username label reflects the focus state
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        //Redraw so that the password label reflects the focus state
      });
    });
  }

  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _unfocusedColor = Colors.grey[600];
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isObscurePassword = true;
  bool circular = false;
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: <Widget>[
                Column(children: <Widget>[
                  const SizedBox(height: 120.0),
                  Image.asset(
                    'assets/Logo.png',
                    height: 150,
                  ),
                ]),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "S??? ??i???n tho???i",
                    labelStyle: TextStyle(
                      color: _phoneFocusNode.hasFocus
                          ? Theme.of(context).colorScheme.secondary
                          : _unfocusedColor,
                    ),
                  ),
                  validator: (value) {
                    if (value!.length<10 ||
                        value == null)
                      return 'Vui l??ng nh???p email ????ng ?????nh d???ng example@gmail.com';
                    else
                      return null;
                  },
                  focusNode: _phoneFocusNode,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: "M???t kh???u",
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
                      return 'Vui l??ng kh??ng ???????c b??? tr???ng m???t kh???u';
                    } else {
                      if (value!.length < 8) {
                        return 'Vui l??ng nh???p m???t kh???u d??i ??t nh???t 8 k?? t???  ';
                      } else {
                        return null;
                      }
                    }
                  },
                  obscureText: _isObscurePassword,
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: TextButton(
                      child:
                          Text('Qu??n m???t kh???u?', style: simpleTextFieltStyle()),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgetPassword()),
                        );
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  child: circular
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('????ng nh???p',
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
                  ),
                  onPressed: () async {
                    setState(() {
                      circular = true;
                    });
                    try {
                      if (_formKey.currentState!.validate()) {
                        AuthMethods authService = AuthMethods();
                        setState(() {
                          circular = false;
                        });
                        var result = await authService.signInWithPhoneAndPass(_phoneController.text, _passwordController.text);
                        print("metaa");
                        if(result == true)
                        {
                          print("Sign in success");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (builder) =>const  Home()),
                                  (route) => false);
                        }
                        else {
                          final snackbar = SnackBar(backgroundColor: Theme.of(context).colorScheme.error,content:Text("S??? ??i???n tho???i ho???c m???t kh???u ???? sai . Vui l??ng nh???p l???i!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }

                      }
                    } catch (e) {
                      final snackbar = SnackBar(backgroundColor: Theme.of(context).colorScheme.error,content:Text("S??? ??i???n tho???i ho???c m???t kh???u ???? sai . Vui l??ng nh???p l???i!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      setState(() {
                        circular = false;
                      });
                    }
                  },
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Ch??a c?? t??i kho???n !',
                    style: simpleTextFieltStyle(),
                  ),
                  TextButton(
                    child: const Text("????ng k?? ngay",
                        style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline)),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      )
                    },
                  )
                ]),
              ],
            )));
  }
}
