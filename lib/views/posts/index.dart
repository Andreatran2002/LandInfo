import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tineviland/views/cards/vertical_card.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        centerTitle: true,
        title : const Text("Tất cả bài đăng ",style: TextStyle(color : Colors.white))
      ),
      body : ListView(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: "Tìm kiếm...",
                  icon: SvgPicture.asset("assets/icons/search.svg"),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
}
