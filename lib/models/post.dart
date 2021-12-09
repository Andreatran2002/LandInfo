import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Category {  all,forSale, forRent,needBuy, needRent }

class Post {
  const Post({
    required this.category,
    required this.id,
    required this.content,
    required this.title,
    required this.price,
    required this.surfaceArea,
    required this.coordinate,

  });

  final Category category;
  final int id;
  final String title;
  final double price;
  final double surfaceArea;
  final String content;
  final LatLng  coordinate;
  //

  @override
  String toString() => "$title (id=$id)";
  // factory Post.fromMap(Map<String, dynamic> json) {
  //   return Post(
  //     json['category'],
  //     json['title'],
  //     json['price'],
  //     json['surfaceArea'],
  //     json['idf'],
  //   );
  // }
}
