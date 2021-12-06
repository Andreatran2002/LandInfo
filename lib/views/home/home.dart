import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../constants.dart';
import 'banner_slider.dart';
import './news_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  late double _scrollPosition;

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
                // image: DecorationImage(
                //   alignment: Alignment.topLeft,
                //   scale: 2.6,
                //   image: AssetImage("assets/images/mainLogo.png"),
                // ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Opacity(
                      opacity: ((90 - _scrollPosition) / 100 >= 0)
                          ? (90 - _scrollPosition) / 100
                          : 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Montserrat",
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
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
                    const SliderForBanner(),
                    SliderForNews(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
