import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final bannerList = [
  "assets/images/image1.jpg",
  "assets/images/image2.jpg",
  "assets/images/image3.jpg",
];

class SliderForBanner extends StatefulWidget {
  const SliderForBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<SliderForBanner> createState() => _SliderForBannerState();
}

class _SliderForBannerState extends State<SliderForBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {}),
        items: bannerList.map((item) {
          return Builder(
            builder: (BuildContext context) {
              var assetImage = AssetImage(item);
              return Container(
                width: 400,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: assetImage,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
