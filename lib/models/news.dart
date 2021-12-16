import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class News {
  const News({
    required this.author_id,
    required this.content,
    required this.title,
    required this.date_created,
    required this.date_updated,
    required this.images
  });

  final String date_created;
  final String date_updated;
  final String author_id;
  final String title;
  final String content;
  final String images;
//


}
