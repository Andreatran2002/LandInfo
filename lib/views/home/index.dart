import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/blocs/user_bloc.dart';
import 'package:tineviland/models/user.dart';
import 'package:tineviland/views/home/land_planning_slider.dart';
import 'package:tineviland/views/home/posts_slider.dart';
import 'package:tineviland/views/land_use_planning/land_planning_page.dart';
import '../../constants.dart';
import './banner_slider.dart';
import './news_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required ScrollController scrollController,
    required this.size,
    required double scrollPosition,
  })  : _scrollController = scrollController,
        _scrollPosition = scrollPosition,
        super(key: key);

  final ScrollController _scrollController;
  final size;
  final double _scrollPosition;

  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    User user = userBloc.user;
    var name = user.Name.split(" ");

    return (user == null)
        ? const CircularProgressIndicator(
            value: 15,
            semanticsLabel: 'Loading!!',
          )
        : SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.3,
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
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
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
                                "Hi " + name[0],
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

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: SliderForBanner(),
                      ),

                      const LandPlanningSlider(title: "Quy ho???ch", collectionName: "landPlannings"),
                      const SliderForNews(
                          title: 'Mua b??n', collectionName: 'news'),
                      const SizedBox(height: 10),
                      const SliderForPosts(
                          title: 'Tin t???c', collectionName: 'posts'),
                      const SizedBox(height: 10),
                      // const SliderForNews(title: 'Tin t???c'),
                      // SliderForNews(),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
