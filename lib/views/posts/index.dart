import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/models/user.dart';

import 'package:tineviland/utils/authmethod.dart';
import 'package:tineviland/views/posts/detail_post.dart';
import '../cards/vertical_card.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  get size => MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tất cả buôn bán",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  GeoPoint geoPoint = snapshot.data!.docs[index].get('locate');
                  double lat = geoPoint.latitude;
                  double lng = geoPoint.longitude;
                  Post post = Post(
                    date_created:
                        snapshot.data!.docs[index].get('date_created').toDate(),
                    date_updated:
                        snapshot.data!.docs[index].get('date_updated').toDate(),
                    author_id: snapshot.data!.docs[index].get('author_id'),
                    coordinate: LatLng(lat, lng),
                    content: snapshot.data!.docs[index].get('content'),
                    category:
                        toCategory(snapshot.data!.docs[index].get('category')),
                    surfaceArea: snapshot.data!.docs[index].get('surfaceArea'),
                    price: snapshot.data!.docs[index].get('price'),
                    image: snapshot.data!.docs[index].get('images'),
                    title: snapshot.data!.docs[index].get('title'),
                  );

                  return HoriCard(
                    size: size,
                    author_id: post.author_id,
                    post: post,
                  );
                },
              );
            }),
      ),
    );
  }

  Category toCategory(num) {
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
}

class HoriCard extends StatefulWidget {
  HoriCard({
    Key? key,
    required this.size,
    required this.author_id,
    required this.post,
  }) : super(key: key);

  final size;
  final author_id;
  final post;

  @override
  State<HoriCard> createState() => _HoriCardState();
}

class _HoriCardState extends State<HoriCard> {
  late User? author = User(
    Name: "",
    Password: "",
    ImageUrl: "loading",
    PhoneNumber: "",
  );

  Future<void> takeAuthorInfo() async {
    User author1 = await AuthMethods.getUser(widget.author_id);
    setState(() => {author = author1});
  }

  String _address = "";

  void GetAddressFromLatLong(LatLng position) async {
    setState(() async {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      _address =
          '${place.subAdministrativeArea} ${place.locality} ${place.administrativeArea}';
    });
  }

  @override
  void initState() {
    super.initState();
    takeAuthorInfo();
    GetAddressFromLatLong(widget.post.coordinate);
  }

  @override
  Widget build(BuildContext context) {
    print(_address);
    print("--------------------------------------------- ddaays nha ");
    final lableContent = returnCategory(widget.post.category);
    return GestureDetector(
      onTap: ()=> Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPost(post: widget.post,))),

      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: widget.size.width * 0.95,
            height: 150,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                    spreadRadius: 1.1,
                  )
                ]),
            child: Row(
              children: [
                Container(
                    width: widget.size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.post.image),
                        fit: BoxFit.cover,
                      ),
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    // author!.ImageUrl == "loading"
                                    //     ? AssetImage("assets\images\default-ImageUrl.png")
                                    NetworkImage(author!.ImageUrl),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    author!.Name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Montserrat",
                                          fontSize: 16,
                                        ),
                                  ),
                                  Text(
                                    author!.PhoneNumber,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: <Widget>[
                              SvgPicture.asset("assets/icons/area.svg"),
                              SizedBox(width: 8),
                              Text(
                                widget.post.surfaceArea.toString() + "m²",
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
                                widget.post.price.toString() + " tr",
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: SvgPicture.asset(
                                  "assets/icons/locate.svg",
                                  width: 8,
                                ),
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  _address,
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
                          child: Text(
                            widget.post.title,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.post.content,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
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
          Positioned(
            left: 0,
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
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
