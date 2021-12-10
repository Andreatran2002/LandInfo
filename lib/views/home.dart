import 'package:flutter/material.dart';
import './home/index.dart';
import './news/index.dart';
import './account/index.dart';
import './posts/add_post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  late double _scrollPosition;
  final screens = [
    const Home(),
    News(),
    AddPost(),
    Account(),
    // const
  ];
  int currentPageIndex = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollPosition = 0;
    super.initState();
  }

  // final headingKey = GlobalKey();
  get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPageIndex,
        onTap: (index) {
          if (index != currentPageIndex) {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => screens[index]));
            setState(() {
              currentPageIndex = index;
            });
          }
        },
        selectedItemColor: const Color(0xff358F38),
        unselectedItemColor: const Color(0xffC4C4C4),
        iconSize: 30,
        selectedLabelStyle: const TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
        items: const [
          BottomNavigationBarItem(
            label: "Nhà chính",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Tin tức",
            icon: Icon(Icons.public),
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            label: "Đăng bài",
            icon: Icon(Icons.cloud_upload),
          ),
          BottomNavigationBarItem(
            label: "Cá Nhân",
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: currentPageIndex == 0
          ? HomePage(
              scrollController: _scrollController,
              size: size,
              scrollPosition: _scrollPosition,
            )
          : screens[currentPageIndex],
    );
  }
}
