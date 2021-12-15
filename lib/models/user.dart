import 'dart:core';

class User {
  const User({
    required this.Name,
    required this.Password,
    required this.PhoneNumber,
    required this.ImageUrl,
  });
  final String Name;
  final String PhoneNumber;
  final String Password;
  final String ImageUrl;
}
