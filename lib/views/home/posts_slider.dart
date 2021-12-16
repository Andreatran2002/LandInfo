import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'package:tineviland/views/posts/detail_post.dart';
import 'package:tineviland/views/posts/index.dart';
import '../cards/vertical_card.dart';
import 'package:intl/intl.dart';

class SliderForNews extends StatefulWidget {
  final String title;
  final String collectionName;
  const SliderForNews({
    Key? key,
    required this.title,
    required this.collectionName,
  }) : super(key: key);

  @override
  State<SliderForNews> createState() => _SliderForNewsState();
}

class _SliderForNewsState extends State<SliderForNews> {
  late List<dynamic> _address = [
    'Địa chỉ',
    'Địa chỉ',
    'Địa chỉ',
    'Địa chỉ',
    'Địa chỉ',
  ];
  void GetAddressFromLatLong(LatLng position, int index) async {
    setState(() async {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      _address[index] =
          '${place.subAdministrativeArea} ${place.locality} ${place.administrativeArea}';
      // isUpdate = !false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Posts(),
                    ),
                  );
                },
                child: Text(
                  "Xem thêm",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontFamily: "Montserrat",
                        color: Colors.green[500],
                      ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 215.0,
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
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
                  itemCount: snapshot.data!.docs.length < 5
                      ? snapshot.data!.docs.length
                      : 5,
                  itemBuilder: (BuildContext context, int index) {
                    // chỗ này là chỗ lấy data
                    bool isHot = false;
                    GeoPoint geoPoint =
                        snapshot.data!.docs[index].get('locate');
                    double lat = geoPoint.latitude;
                    double lng = geoPoint.longitude;
                    Post post = Post(
                      date_created: snapshot.data!.docs[index]
                          .get('date_created')
                          .toDate(),
                      date_updated: snapshot.data!.docs[index]
                          .get('date_updated')
                          .toDate(),
                      author_id: snapshot.data!.docs[index].get('author_id'),
                      coordinate: LatLng(lat, lng),
                      content: snapshot.data!.docs[index].get('content'),
                      category: toCategory(
                          snapshot.data!.docs[index].get('category')),
                      surfaceArea:
                          snapshot.data!.docs[index].get('surfaceArea'),
                      price: snapshot.data!.docs[index].get('price'),
                      image: snapshot.data!.docs[index].get('images'),
                      title: snapshot.data!.docs[index].get('title'),
                    );

                    final lableContent = returnCategory(post.category);

                    GetAddressFromLatLong(post.coordinate, index);
                    final addressString = _address[index];

                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPost(post: post)))
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4, bottom: 4, left: 20),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      child: FadeInImage.assetNetwork(
                                        // fadeInCurve: Curves.bounceIn,
                                        fadeInDuration: Duration(
                                          milliseconds: 500,
                                        ),
                                        placeholder:
                                            'assets/images/loading.gif',
                                        image: post.image,
                                        fit: BoxFit.cover,
                                        width: 180,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: <Widget>[
                                          SvgPicture.asset(
                                              "assets/icons/area.svg"),
                                          SizedBox(width: 8),
                                          Text(
                                            post.surfaceArea.toString() + "m²",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ]),
                                        Row(children: <Widget>[
                                          SvgPicture.asset(
                                            "assets/icons/money.svg",
                                            width: 10,
                                          ),
                                          // SizedBox(width: 8),
                                          Text(
                                            post.price.toString() + " tr",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ]),
                                        // Row()
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 1),
                                          child: SvgPicture.asset(
                                            "assets/icons/locate.svg",
                                            width: 8,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            addressString,
                                            // ",",
                                            // _address[index].toString() == ""
                                            //     ? ""
                                            //     : _address[index].toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            post.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 16,
                                                ),
                                          ),
                                          Container(
                                            child: Text(
                                              post.content,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
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
                                color: lableContent["color"],
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
                                    lableContent["name"],
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

  Category toCategory(int num) {
    switch (num) {
      case 0:
        return Category.all;
      case 1:
        return Category.forSale;
      case 2:
        return Category.forRent;
      case 3:
        return Category.needBuy;
      case 4:
        return Category.needRent;
    }
    return Category.all;
  }

  Map<String, dynamic> returnCategory(dynamic cate) {
    switch (cate) {
      case Category.all:
        return {"name": "Tất cả", "color": Colors.green};
      case Category.forSale:
        return {"name": "Bán", "color": Colors.yellow[700]};
      case Category.forRent:
        return {"name": "Thuê", "color": Colors.orange};
      case Category.needBuy:
        return {"name": "Cần mua", "color": Colors.red};
      case Category.needRent:
        return {"name": "Cần thuê", "color": Colors.red[600]};
    }
    return {"name": "Tất cả", "color": Colors.green};
  }
}
