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
    // AddPost(),
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
            if (index == 2) {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Chọn loại bài đăng!'),
                  // content: Row(
                  //   children: <Widget>[],
                  // ),
                  actions: [
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Column(
                              children: [
                                Image.asset('assets/images/trade.png',
                                    width: 135),
                                Text('Tin tức'),
                              ],
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'cancel');
                              setState(() {
                                currentPageIndex = 2;
                              });
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/news.png',
                                    width: 135),
                                Text('Buôn bán'),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              );
            } else {
              setState(() {
                currentPageIndex = index;
              });
            }
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
