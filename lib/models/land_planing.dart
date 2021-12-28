
import 'package:latlong2/latlong.dart';
class LandPlanning {
  LandPlanning({
    required this.title,
    required this.content,
    required this.date_created,
    required this.accessToken,
    required this.isValidated,
    required this.mapUrl,
    required this.imageUrl,
    required this.center

});
  final String title ;
  final String content ;
  final DateTime date_created;
  final bool isValidated;
  final String mapUrl;
  final String accessToken;
  final String imageUrl;
  final LatLng center;
}