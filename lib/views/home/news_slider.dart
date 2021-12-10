import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../cards/vertical_card.dart';

class SliderForNews extends StatelessWidget {
  final String title;
  const SliderForNews({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          // margin: const EdgeInsets.symmetric(vertical: 10.0),
          height: 220.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const <Widget>[
              SizedBox(width: 20),
              VerticalCard(
                  type: 'trade', news_type: 'new', labelContent: 'Tin Mới'),
              SizedBox(width: 10),
              VerticalCard(
                  type: 'trade', news_type: 'near', labelContent: 'Gần đây'),
              SizedBox(width: 10),
              VerticalCard(
                  type: 'trade', news_type: 'new', labelContent: 'Tin Mới'),
              SizedBox(width: 10),
              VerticalCard(
                  type: 'trade', news_type: 'new', labelContent: 'Tin Mới'),
              SizedBox(width: 10),
              VerticalCard(type: 'news', news_type: 'near', labelContent: ''),
            ],
          ),
        ),
      ],
    );
  }
}
