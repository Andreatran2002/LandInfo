import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'package:tineviland/views/news/detail_news.dart';
import 'package:tineviland/views/posts/detail_post.dart';
import '../cards/vertical_card.dart';
import 'package:intl/intl.dart';

class SliderForPosts extends StatefulWidget {
  final String title;
  final String collectionName;
  const SliderForPosts({
    Key? key,
    required this.title,
    required this.collectionName,
  }) : super(key: key);

  @override
  State<SliderForPosts> createState() => _SliderForPostsState();
}

class _SliderForPostsState extends State<SliderForPosts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          // margin: const EdgeInsets.symmetric(vertical: 10.0),
          height: 220.0,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                if (snapshot.hasError) {
                  print("hello" + snapshot.error.toString());
                  return Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // chỗ này là chỗ lấy data
                    bool isHot = false;
                    GeoPoint geoPoint =   snapshot.data!.docs[index].get('locate');
                    double lat = geoPoint.latitude;
                    double lng = geoPoint.longitude;
                    Post post = Post(
                        date_created: snapshot.data!.docs[index].get('date_created').toDate(),
                        date_updated: snapshot.data!.docs[index].get('date_updated').toDate(),
                        author_id: snapshot.data!.docs[index].get('author_id'),
                        coordinate: LatLng(lat, lng),
                        content: snapshot.data!.docs[index].get('content'),
                        category: toCategory(snapshot.data!.docs[index].get('category')),
                        surfaceArea: snapshot.data!.docs[index].get('surfaceArea'),
                        price: snapshot.data!.docs[index].get('price'),
                        image: snapshot.data!.docs[index].get('images'),
                        title: snapshot.data!.docs[index].get('title'),
                    );
                    return GestureDetector(
                      onTap: ()=>{
                        Navigator.push(context,  MaterialPageRoute(
                            builder: (context) =>   DetailPost(post : post)))
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 20),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(2, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: const Offset(0, 2),
                                          blurRadius: 2,
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(post.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              post.title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Montserrat",
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              post.content,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Montserrat",
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 2,
                                bottom: 2,
                                left: 5,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isHot ? Colors.red : Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(2, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset('assets/icons/fire.svg'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    isHot ? 'Tin mới' : 'Tin cũ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),

        ),
      ],
    );
  }
  Category toCategory(int num){
    switch(num){
      case 0 : return Category.all;
      case 1 : return Category.forSale;
      case 2 : return Category.forRent;
      case 3: return Category.needBuy;
      case 4: return Category.needRent;
    }
    return Category.all;
  }
}
