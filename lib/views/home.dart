import 'package:flutter/material.dart';
import './home/index.dart';
import './news/index.dart';
import './account/index.dart';
import './posts/add_post.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tineviland/views/news/add_new.dart';
import '../constants.dart';
import 'home/banner_slider.dart';
import 'home/news_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  late double _scrollPosition;
  int currentPageIndex = 0;
  final screens = [
    Home(),
    News(),
    AddPost(),
    Account(),
    // AddPost(),
    // const
  ];

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
        items: [
          BottomNavigationBarItem(
            label: "Nhà chính",
            icon: TextButton(
              child: Icon(Icons.home),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                )
              },
            ),
          ),
          BottomNavigationBarItem(
            label: "Tin tức",
            icon: IconButton(
              icon: const Icon(Icons.public),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNew()),
                )
              },
            ),
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
