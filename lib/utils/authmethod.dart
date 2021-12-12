import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:tineviland/views/auth/signin.dart';
import 'package:tineviland/views/home.dart';
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

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> signUpWithPhoneNumber(
      String verificationId, String smsCode, BuildContext context, user_account.User user) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const SignIn()),
          (route) => false);
      FirebaseFirestore.instance.collection("users").add({
        "username" :    user.Name,
        "avatar": "",
        "phone" : user.PhoneNumber,
        "postIds": "",
        "password" : setPassword(user.Password),
      });

      showSnackBar(context, "logged In");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  String setPassword( String password) { // 1
    String hashedPassword = Crypt.sha256(password).toString();
    return hashedPassword;
  }
  Future<bool> checkPassword(String storedHashedPassword, String password) async {
    return Future.value(Crypt(storedHashedPassword).match(password)); // 3
  }
}
