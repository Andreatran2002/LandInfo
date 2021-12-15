import 'dart:core';

class User {
  const User({
    required this.Name,
    required this.Password,
    required this.PhoneNumber,
    required this.Avatar,
  });
  final String Name;
  final String PhoneNumber;
  final String Password;
  final String Avatar;
}
