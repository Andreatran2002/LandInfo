import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tineviland/models/user.dart';
import 'package:tineviland/utils/authmethod.dart';

class DetailNews extends StatefulWidget {
  const DetailNews(
      {required this.img,
      required this.content,
      required this.title,
      required this.author_id,
      Key? key})
      : super(key: key);
  final String img;
  final String content;
  final String title;
  final String author_id;
  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  late User author;

  @override
  void initState() {
    super.initState();
    takeAuthorInfo();
  }

  @override
  Widget build(BuildContext context) {
    takeAuthorInfo();
    return (author == null)
        ? const CircularProgressIndicator(
            value: 15,
            semanticsLabel: 'Loading!!',
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Chi tiết",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  author.ImageUrl != ""
                                      ? author.ImageUrl
                                      : "https://firebasestorage.googleapis.com/v0/b/tinevyland.appspot.com/o/avatar%2Fdefault-avatar.png?alt=media&token=57c2019d-3687-4984-9bb4-42a7c30dea87",
                                ))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        author != null ? author.Name + "   " : "",
                        style: const TextStyle(
                          wordSpacing: 2,
                          fontSize: 20,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      widget.content,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> takeAuthorInfo() async {
    User author1 = await AuthMethods.getUser(widget.author_id);
    setState(() => {author = author1});
  }

  Widget authorInfo() {
    return Container(
      child: Text(
        author != null ? author.Name + "   " : "",
        style: const TextStyle(
          wordSpacing: 2,
          fontSize: 17,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
