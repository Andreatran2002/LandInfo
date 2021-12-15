import 'dart:core';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class User{
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