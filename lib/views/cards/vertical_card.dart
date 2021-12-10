import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  final String type;
  final String news_type;
  final String labelContent;

  const VerticalCard({
    Key? key,
    required this.type,
    required this.news_type,
    required this.labelContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
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
                  borderRadius: BorderRadius.circular(5),
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
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: <Widget>[
                                  SvgPicture.asset("assets/icons/area.svg"),
                                  SizedBox(width: 8),
                                  Text(
                                    '93m2',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
                                          fontSize: 12,
                                        ),
                                  ),
                                ]),
                                // Row()
                              ],
                            ),
                            const SizedBox(height: 3),
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
                                  padding: const EdgeInsets.symmetric(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
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
                                margin: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Đầu hẻm Huỳnh Tấn Phát 5x19, full dân, tiện ích bao quanh',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
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
            ),
          ),
          Positioned(
            left: 0,
            top: 10,
            child: Container(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 2,
                left: 5,
                right: 10,
              ),
              // color: Colors.red,
              decoration: BoxDecoration(
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset('assets/icons/fire.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    labelContent,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
