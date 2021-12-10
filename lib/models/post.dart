import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Category {  all,forSale, forRent,needBuy, needRent }

class Post {
  const Post({
    required this.category,
    required this.author_id,
    required this.content,
    required this.title,
    required this.price,
    required this.surfaceArea,
    required this.coordinate,
    required this.images
  });

  final Category category;
  final String author_id;
  final String title;
  final double price;
  final double surfaceArea;
  final String content;
  final LatLng  coordinate;
  final List<String> images;
  //


}
