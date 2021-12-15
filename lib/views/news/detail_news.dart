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
    return (author == null) ?
    const CircularProgressIndicator(
      value: 15,
      semanticsLabel: 'Loading!!',
    )
        :  Scaffold(
        appBar: AppBar(
          title: const Text("Chi tiết", style: TextStyle(color: Colors.white)),
        ),
        body: ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(0, 2),
                    blurRadius: 0.3,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                          child: Text(widget.title,
                              style: TextStyle(fontSize: 25))),
                      const Divider(
                        height: 15,
                        thickness: 1,
                      ),
                      Text(
                        widget.content,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 15,
                  thickness: 1,
                ),
                authorInfo()
              ],
            ));
  }

  Future<void> takeAuthorInfo() async {
    User author1 = await AuthMethods.getUser(widget.author_id);
    setState(() => {author = author1});
  }

  Widget authorInfo() {
    return Container(
      alignment: Alignment.topRight,
      child: Text(author != null ? author.Name+"   " : "" ,
          style: const TextStyle(
              wordSpacing: 2,
              fontSize: 17),),
    );
  }
}