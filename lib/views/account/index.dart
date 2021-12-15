import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/blocs/user_bloc.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'package:tineviland/utils/storage_service.dart';
// import 'package:settings_ui/pages/settings.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  AuthMethods authMethod = AuthMethods();
  bool showPassword = false;
  get size => MediaQuery.of(context).size;
  File? file;
  String? fileName;
  String? fileUrl;
  String? url;
  final Storage storage = Storage();

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hình ảnh không hợp lệ vui lòng nhập lại!"),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Tải hình ảnh thành công !!"),
        backgroundColor: Colors.green,
      ),
    );
    final path = result.files.single.path!;
    final name = result.files.single.name;

    setState(() => {
          file = File(path),
          fileName = name,
        });
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    var user = userBloc.user;

    return Scaffold(
      body: (userBloc.user == null)
          ? const CircularProgressIndicator(
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
                      const Center(
                        child: Text("Thông tin tài khoản",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
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
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
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
                                        (user.ImageUrl != "")
                                            ? user.ImageUrl
                                            : "https://firebasestorage.googleapis.com/v0/b/tinevyland.appspot.com/o/avatar%2Fdefault-avatar.png?alt=media&token=57c2019d-3687-4984-9bb4-42a7c30dea87",
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
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: GestureDetector(
                                    onTap: () => selectFile(),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(

                              child: Text("Lưu", style : TextStyle(fontSize: 18)),
                              onPressed: () async {
                                url = await storage.uploadFile(
                                  context,
                                  file,
                                  fileName!,
                                  fileUrl,
                                );
                                if (url!.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Đã có lỗi khi tải ảnh lên !!"),
                                  ));
                                } else {
                                  AuthMethods auth = AuthMethods();
                                  auth.updateAvatar(url!);
                                  //     .then((value)  {
                                  //   setState(() {
                                  //     user = User(user.Name, user.Password, user.PhoneNumber, url);
                                  //   });
                                  // });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,
                                          content:
                                          Text("Cập nhập ảnh đại diện thành công!")));

                                }
                              },
                              style: ButtonStyle(
                              ),
                            ),
                            OutlineButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () async {
                                setState(() async {
                                  await authMethod.signOut();
                                  authMethod.showSnackBar(
                                      context, "Đã đăng xuất");
                                });
                              },
                              child: const Text("SIGN OUT",
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 2.2,
                                      color: Colors.black)),
                            ),
                          ])
                    ],
                  )),
            ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(labelText, style: const TextStyle(fontSize: 18)),
          SizedBox(height: 5),
          Text(placeholder,
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary)),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
