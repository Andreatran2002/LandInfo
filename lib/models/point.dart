
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
class Point{
  Marker? _marker;
  Marker? get marker => _marker;
  set marker(newPoint) => _marker = newPoint;
}