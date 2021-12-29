import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:tineviland/views/news/detail_news.dart';
import 'package:tineviland/views/news/index.dart';

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
                      builder: (context) => const News(),
                    ),
                  );
                },
                child: Text(
                  "Xem thêm",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontFamily: "Montserrat",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 210.0,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('news').snapshots(),
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
                  itemCount: snapshot.data!.docs.length < 6 ? snapshot.data!.docs.length : 5 ,
                  itemBuilder: (BuildContext context, int index) {
                    // chỗ này là chỗ lấy data

                    final title = snapshot.data!.docs[index].get('title');
                    final content = snapshot.data!.docs[index].get('content');
                    final imageUrl = snapshot.data!.docs[index].get('images');
                    final authorId =
                    snapshot.data!.docs[index].get('author_id');
                    bool isHot = false;
                    final dateCreated =snapshot.data!.docs[index].get('date_created').toDate();

                    return PostCard(
                        content: content,
                        imageUrl: imageUrl,
                        title: title,
                        authorId: authorId,
                        isHot: isHot,
                        dateCreated : dateCreated);
                  },
                );
              }),
        ),
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.content,
    required this.imageUrl,
    required this.title,
    required this.authorId,
    required this.isHot,
    required this.dateCreated
  }) : super(key: key);

  final content;
  final imageUrl;
  final title;
  final authorId;
  final bool isHot;
  final DateTime dateCreated;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailNews(
                  content: content,
                  img: imageUrl,
                  title: title,
                  author_id: authorId,
                  date_created: dateCreated,)))
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
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              title,
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
                          ),
                          Container(
                            child: Text(
                              content,
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
                color: Colors.red,
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
                    'Tin mới',
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
}
