import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tineviland/models/user.dart';
import 'package:tineviland/utils/authmethod.dart';

class UserBloc with ChangeNotifier {
  String? currentUser;
  final AuthMethods _authMethods = AuthMethods();
  late User user =  User(
    Name: "",
    Password: "",
    PhoneNumber: "",
    ImageUrl: "assets\images\default-avatar.png",
  );
  UserBloc() {
    setCurrentUser();
  }
  setCurrentUser() async {
    currentUser = await _authMethods.getUserId();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        user = User(
            Password: documentSnapshot["password"],
            Name: documentSnapshot["username"],
            PhoneNumber: documentSnapshot["phone"],
            ImageUrl: documentSnapshot["avatar"]);
        print(documentSnapshot["username"]);
      }
    });
    notifyListeners();
  }
}
