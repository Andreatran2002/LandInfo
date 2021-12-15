import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tineviland/views/auth/phoneauth.dart';
import 'signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tineviland/models/user.dart' as user_account;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      setState(() {

      });
    });
    _usernameFocusNode.addListener(() {
      setState(() {
        //Redraw so that the username label reflects the focus state
      });
    });
    _repeatpasswordFocusNode.addListener(() {
      setState(() {
        //Redraw so that the username label reflects the focus state
      });
    });
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatpasswordController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _unfocusedColor = Colors.grey[600];

  final _passwordFocusNode = FocusNode();
  final _repeatpasswordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _formSignUpKey = GlobalKey<FormState>();
  final _authPhoneKey = GlobalKey<FormState>();
  bool _isObscurePassword = true;
  bool _isObscureRepeatPassword = true;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formSignUpKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: <Widget>[
                const SizedBox(height: 0.0),
                Column(children: <Widget>[
                  const SizedBox(height: 120.0),
                  Image.asset(
                    'assets/Logo.png',
                    height: 150,
                  ),
                ]),

                const SizedBox(height: 10.0),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Tên đăng nhập",
                    labelStyle: TextStyle(
                      color: _usernameFocusNode.hasFocus
                          ? Theme.of(context).colorScheme.secondary
                          : _unfocusedColor,
                    ),
                  ),
                  validator: (value) {
                    if (value == "") {
                      return 'Vui lòng nhập tên đăng nhập';
                    }
                    if (value!.length < 3)
                      return "Tên đăng nhập phải hơn 3 kí tự";
                  },
                  focusNode: _usernameFocusNode,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: "Mật khẩu",
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
                      labelText: "Nhập lại mật khẩu",
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
                const SizedBox(height: 20.0),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonMinWidth: 300,
                  children: <Widget>[
                    ElevatedButton(
                      child: Center(
                        widthFactor: 8.0,
                        heightFactor: 1.3,
                        child: circular
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Đăng kí tài khoản',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
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
                      onPressed: () async {

                        setState(() {
                          circular = true;
                        });
                        try {
                          if (_formSignUpKey.currentState!.validate()) {

                            setState(() {
                              circular = false;
                            });


                            showInformationDialog(context);
                            // Navigator.pushAndRemoveUntil(context,
                            //     MaterialPageRoute(builder: (builder)=> const SignIn()),
                            //         (route) => false);
                          }
                        } catch (e){
                          final snackbar = SnackBar(content : Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          setState(() {
                            circular = false;
                          });
                        }
                      },
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Nếu bạn đã có tài khoản thì hãy vào ',
                              style: TextStyle(fontSize: 11)),
                          TextButton(
                            child: const Text("Đăng nhập",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11)),
                            onPressed: () {
                              _usernameController.clear();
                              _repeatpasswordController.clear();
                              _phonenumberController.clear();
                              _passwordController.clear();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()),
                                  (route) => false);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }

  Future<void> showInformationDialog(BuildContext context) async {
    user_account.User user = user_account.User(
        Name: _usernameController.text,
        Password:  _passwordController.text,
        PhoneNumber: _phonenumberController.text,
        ImageUrl: ""
    );

    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content:  phoneAuth(account : user),
              actions: <Widget>[
                InkWell(
                  child: const Text('Đóng', style : TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  onTap: () {

                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

}
