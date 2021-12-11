import 'package:flutter/material.dart';
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
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedItemColor: const Color(0xff358F38),
        unselectedItemColor: const Color(0xffC4C4C4),
        iconSize: 30,
        selectedLabelStyle: const TextStyle(
          fontFamily: "Montserrat",
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "Montserrat",
        ),
        items:  [
          BottomNavigationBarItem(
            label: "Nhà chính",
            icon: TextButton(
                child: Icon(Icons.home),
              onPressed: ()=> {
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
              onPressed:  ()=> {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  const AddNew()),
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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                color: kGreenLightColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Opacity(
                    opacity: ((90 - _scrollPosition) / 100 >= 0)
                        ? (90 - _scrollPosition) / 100
                        : 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        // key: headingKey,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/mainLogo.png",
                            height: 90,
                          ),
                          Text(
                            "Chào, Vy",
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Montserrat",
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: SliderForBanner(),
                  ),
                  const SliderForNews(title: 'Mua bán'),
                  const SizedBox(height: 10),
                  const SliderForNews(title: 'Tin tức'),
                  // SliderForNews(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
