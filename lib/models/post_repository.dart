// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'post.dart';

class PostsRepository {
  static List<Post> loadPosts(Category category) {
    const allPosts = <Post> [
      Post(
        category: Category.forRent,
          author_id: 'AEzSQEo6wIwuSK7ATG0M',
        surfaceArea: 222.3,
        title: 'Vagabond sack',
        price: 120,
        content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
        coordinate : const LatLng(23,23),
        images:  []

      ),
      Post(
          category: Category.forRent,
        author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
    ,coordinate : const LatLng(23,23),
          images:  [],
      ),
      Post(
          category: Category.forRent,
        author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),
      Post(
          category: Category.forRent,
        author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),
      Post(
          category: Category.forRent,
        author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),
      Post(
          category: Category.forRent,
        author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),
      Post(
          category: Category.forRent,
          author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),
      Post(
          category: Category.forRent,
        author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),
      Post(
          category: Category.forRent,
        author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),
      Post(
          category: Category.forRent,
        author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),
      Post(
          category: Category.forRent,
          author_id: 'AEzSQEo6wIwuSK7ATG0M',
          surfaceArea: 222.3,
          title: 'Vagabond sack',
          price: 120,
          content: " orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. "
        ,coordinate : const LatLng(23,23),
        images:  [],
      ),



    ];
    if (category == Category.all) {
      return allPosts;
    } else {
      return allPosts.where((Post p) {
        return p.category == category;
      }).toList();
    }
  }
  static String printCategory(Category category){
    switch(category){
      case Category.all: return "Tất cả";
      case Category.forRent: return "Cho thuê";
      case Category.forSale: return "Cần bán";
      case Category.needRent: return "Cần thuê";
      case Category.needBuy: return "Cần mua";
    }
  }
}
