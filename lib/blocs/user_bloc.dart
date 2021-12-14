import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tineviland/models/user.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'package:tineviland/utils/geolocator_service.dart';

class UserBloc with ChangeNotifier  {
  String? currentUser ;
  AuthMethods _authMethods = AuthMethods();
  UserBloc(){
    setCurrentUser();
  }
  setCurrentUser() async  {
    currentUser = await _authMethods.getUserId();
    notifyListeners();
  }

}
