import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'package:tineviland/views/news/detail_news.dart';
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
          height: 230.0,
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
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // chỗ này là chỗ lấy data
                    final title = snapshot.data!.docs[index].get('title');
                    final content = snapshot.data!.docs[index].get('content');
                    final imageUrl = snapshot.data!.docs[index].get('images');
                    final authorId =
                        snapshot.data!.docs[index].get('author_id');
                    bool isHot = false;
                    final dateCreated = DateFormat('MMMM d, yyyy', 'en_US');

                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailNews(
                                    content: content,
                                    img: imageUrl,
                                    title: title,
                                    author_id: authorId)))
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
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
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
                                            '93m2',
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
                                            width: 16,
                                          ),
                                          // SizedBox(width: 8),
                                          Text(
                                            '93m2',
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1),
                                              child: SvgPicture.asset(
                                                "assets/icons/locate.svg",
                                                width: 8,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Hồ Chí Minh',
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
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            // vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.green,
                                            ),
                                          ),
                                          child: Text(
                                            'Mua',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                ),
                                          ),
                                        )
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
                                            title,
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
                                          Container(
                                            child: Text(
                                              content,
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
          // ListView(
          //   scrollDirection: Axis.horizontal,
          //   children: const <Widget>[
          //     SizedBox(width: 20),
          //     VerticalCard(
          //         type: 'trade', news_type: 'new', labelContent: 'Tin Mới'),
          //     SizedBox(width: 10),
          //     VerticalCard(
          //         type: 'trade', news_type: 'near', labelContent: 'Gần đây'),
          //     SizedBox(width: 10),
          //     VerticalCard(
          //         type: 'trade', news_type: 'new', labelContent: 'Tin Mới'),
          //     SizedBox(width: 10),
          //     VerticalCard(
          //         type: 'trade', news_type: 'new', labelContent: 'Tin Mới'),
          //     SizedBox(width: 10),
          //     VerticalCard(type: 'news', news_type: 'near', labelContent: ''),
          //   ],
          // ),
        ),
      ],
    );
  }
}
