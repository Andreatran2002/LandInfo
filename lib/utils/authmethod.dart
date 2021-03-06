import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:tineviland/views/auth/signin.dart';
import 'package:crypt/crypt.dart';
import 'package:tineviland/models/user.dart' as user_account;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();
  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  void storeTokenAndPhone(String phone) async {
    print("storing token and data");
    await storage.write(key: "token", value: Crypt.sha256(phone).toString());
    await storage.write(key: "phone", value: phone);
    print(phone);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<String?> getUserId() async {
    String? userId;
    var userPhone = await storage.read(key: "phone");
    await FirebaseFirestore.instance
        .collection("users")
        .where('phone', isEqualTo: userPhone)
        .get()
        .then((data) {
      userId = data.docs[0].id;
    });
    return Future<String>.value(userId);
  }


  Future<bool> hasAccount(String phone) async {
    String? userId;
    var userPhone = await storage.read(key: "phone");
    await FirebaseFirestore.instance
        .collection("users")
        .where('phone', isEqualTo: userPhone)
        .get()
        .then((data) {
      userId = data.docs[0].id;
    });
    if (userId != null ) return Future<bool>.value(true);
    return Future<bool>.value(false);
  }

  Future<void> signUpWithPhoneNumber(String verificationId, String smsCode,
      BuildContext context, user_account.User user, String phone) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const SignIn()),
          (route) => false);
      FirebaseFirestore.instance.collection("users").add({
        "username": user.Name,
        "avatar": "",
        "phone": phone,
        "postIds": "",
        "password": setPassword(user.Password),
      });

      showSnackBar(context, "????ng k?? t??i kho???n th??nh c??ng",Theme.of(context).colorScheme.primary);
    } catch (e) {
      showSnackBar(context,"X??c th???c kh??ng th??nh c??ng. Vui l??ng ki???m tra l???i!",Theme.of(context).colorScheme.error);
    }
  }

  Future<void> authenticationByPhone(String verificationId, String smsCode, String phone,BuildContext context,)async {
    try{
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      showSnackBar(context, "X??c th???c t??i kho???n th??nh c??ng",Theme.of(context).colorScheme.primary);

    }
    catch(e){
      showSnackBar(context,"X??c th???c kh??ng th??nh c??ng. Vui l??ng ki???m tra l???i!",Theme.of(context).colorScheme.error);
    }

  }

  void showSnackBar(BuildContext context, String text, Color backgroundColor) {
    final snackBar = SnackBar(content: Text(text), backgroundColor: backgroundColor,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String setPassword(String password) {
    // 1
    String hashedPassword = Crypt.sha256(password).toString();
    return hashedPassword;
  }

  Future<bool> signInWithPhoneAndPass(String phone, String password) async {
    var result;
    await FirebaseFirestore.instance
        .collection("users")
        .where('phone', isEqualTo: phone)
        .get()
        .then((data) {
      result = Crypt(data.docs[0]['password']).match(password);
      print("Mat khau dung");
      if (result) {
        storeTokenAndPhone(phone);
      }
    });

    return Future<bool>.value(result);
  }

  static Future<user_account.User> getUser(String userId) async {
    user_account.User user = user_account.User(
        Password: "", Name: "", PhoneNumber: "", ImageUrl: "");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        user = user_account.User(
            Password: documentSnapshot["password"],
            Name: documentSnapshot["username"],
            PhoneNumber: documentSnapshot["phone"],
            ImageUrl: documentSnapshot["avatar"]);
        print(documentSnapshot["username"]);
      }
    });
    return user;
  }

  Future<void> updateAvatar(String avatar) async {
    String? userId = await getUserId();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'avatar': avatar}).then((value) => print("???? updaate avatar"));
  }

  Future<void> signOut() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'phone');
  }
}
