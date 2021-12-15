import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'post.dart';

class PostsRepository {
  // static List<Post> loadPosts(Category category) {
  //   //get Data
  //
  //   if (category == Category.all) {
  //     return allPosts;
  //   } else {
  //     return allPosts.where((Post p) {
  //       return p.category == category;
  //     }).toList();
  //   }
  // }

  static String printCategory(Category category) {
    switch (category) {
      case Category.all:
        return "Tất cả";
      case Category.forRent:
        return "Cho thuê";
      case Category.forSale:
        return "Cần bán";
      case Category.needRent:
        return "Cần thuê";
      case Category.needBuy:
        return "Mua";
    }
  }
}
