import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/blocs/user_bloc.dart';
import 'package:tineviland/utils/authmethod.dart';
// import 'package:settings_ui/pages/settings.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  AuthMethods authMethod = AuthMethods();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    var user = userBloc.user;
    return Scaffold(
      body: (userBloc.user== null) ?
      const CircularProgressIndicator(
        value: 15,
        semanticsLabel: 'Loading!!',
      )
          : Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Center(child: Text("Thông tin tài khoản", style: TextStyle(fontSize: 25, fontWeight:FontWeight.w600)),),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                (user.ImageUrl != "")? user.ImageUrl:
                                "https://firebasestorage.googleapis.com/v0/b/tinevyland.appspot.com/o/avatar%2Fdefault-avatar.png?alt=media&token=57c2019d-3687-4984-9bb4-42a7c30dea87",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("Tên đăng nhập ", user.Name, false),
              buildTextField("Số điện thoại", user.PhoneNumber, false),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: OutlineButton(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async {
                    setState(() async {
                    await authMethod.signOut();
                    authMethod.showSnackBar(context, "Đã đăng xuất");

                    });

                  },
                  child: const Text("SIGN OUT",
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
              )

                ],
              )
          ),
        ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding:const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle:const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
