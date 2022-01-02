import 'dart:core';
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
    required this.image,
    required this.date_created,
    required this.date_updated,
  });

  final Category category;
  final String author_id;
  final String title;
  final int price;
  final int surfaceArea;
  final String content;
  final LatLng  coordinate;
  final String image;
  final DateTime date_created;
  final DateTime date_updated;
  //


}
