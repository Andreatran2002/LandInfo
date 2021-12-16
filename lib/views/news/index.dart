import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tineviland/models/user.dart';

import 'package:tineviland/utils/authmethod.dart';
import 'package:tineviland/views/news/detail_news.dart';
import '../cards/vertical_card.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  get size => MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tất cả tin",
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
            stream: FirebaseFirestore.instance.collection('news').snapshots(),
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
                  final title = snapshot.data!.docs[index].get('title');
                  final content = snapshot.data!.docs[index].get('content');
                  final imageUrl = snapshot.data!.docs[index].get('images');
                  final author_id = snapshot.data!.docs[index].get('author_id');
                  final date_created = snapshot.data!.docs[index].get('date_created').toDate();
                  return GestureDetector(
                    onTap: ()=>  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailNews(date_created: date_created ,img: imageUrl,content: content,author_id: author_id,title: title,))),
                    child: HoriCard(
                      size: size,
                      imageUrl: imageUrl,
                      title: title,
                      content: content,
                      author_id: author_id,
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}

class HoriCard extends StatefulWidget {
  HoriCard({
    Key? key,
    required this.size,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.author_id,
  }) : super(key: key);

  final size;
  final imageUrl;
  final title;
  final content;
  final author_id;

  @override
  State<HoriCard> createState() => _HoriCardState();
}

class _HoriCardState extends State<HoriCard> {
  late User? author = new User(
    Name: "",
    Password: "",
    ImageUrl: "loading",
    PhoneNumber: "",
  );

  Future<void> takeAuthorInfo() async {
    User author1 = await AuthMethods.getUser(widget.author_id);
    setState(() => {author = author1});
  }

  @override
  void initState() {
    super.initState();
    takeAuthorInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.9,
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
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
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
                placeholder: 'assets/images/loading.gif',
                image: widget.imageUrl,
                fit: BoxFit.cover,
                width: 180,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                  Flexible(
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                          ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
    );
  }
}
