import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class SliderForNews extends StatelessWidget {
  const SliderForNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mua bán',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
          ),
          Container(
            // margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 220.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const <Widget>[
                VerticalCard(),
                SizedBox(width: 10),
                VerticalCard(),
                SizedBox(width: 10),
                VerticalCard(),
                SizedBox(width: 10),
                VerticalCard(),
                SizedBox(width: 10),
                VerticalCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalCard extends StatelessWidget {
  const VerticalCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        // padding: const EdgeInsets.all(10),
        width: 180.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(2, 2),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1583417319070-4a69db38a482?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: <Widget>[
                          SvgPicture.asset("assets/icons/area.svg"),
                          SizedBox(width: 8),
                          Text(
                            '93m2',
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                    ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/money.svg",
                            width: 16,
                          ),
                          // SizedBox(width: 8),
                          Text(
                            '93m2',
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                    ),
                          ),
                        ]),
                        // Row()
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 1),
                              child: SvgPicture.asset(
                                "assets/icons/locate.svg",
                                width: 10,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Hồ Chí Minh',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9,
                            // vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.green,
                            ),
                          ),
                          child: Text(
                            'Mua',
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                    ),
                          ),
                        )
                      ],
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'Đầu hẻm Huỳnh Tấn Phát 5x19, full dân, tiện ích bao quanh',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                    ),
                    // Row(children: []),
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
