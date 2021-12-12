import 'package:flutter/material.dart';
class PlaceSearch {
  PlaceSearch({this.description, this.placeId});
  final String? description;
  final String? placeId ;
  factory PlaceSearch.fromJson(Map<String,dynamic> json){
    return PlaceSearch(
      description: json['description'],
      placeId:  json['place_id'],
    );
  }
}