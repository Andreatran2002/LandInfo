import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tineviland/models/land_planing.dart';
import 'package:tineviland/views/land_use_planning/detail_map_land_planning.dart';

class LandPlanningCardSlider extends StatelessWidget {
  const LandPlanningCardSlider({
    Key? key,
    required this.landPlanning
  }) : super(key: key);

  final LandPlanning landPlanning;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailMapLandPlanning(landPlanning: landPlanning)))
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 20),
            child: Container(
              width: 180,
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
                children: <Widget>[
                  Container(
                    height: 100,
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
                      image: DecorationImage(
                        image: NetworkImage(landPlanning.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(
                              landPlanning.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                                fontSize: 16,
                              ),

                          ),
                          Text(landPlanning.isValidated ? "Tình trạng:  Còn hiệu lực": "Tình trạng: Mất hiệu lực", style : TextStyle(fontSize: 12,color : Theme.of(context).colorScheme.primary)),
                          Text(
                              landPlanning.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 10,
            child: Container(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 2,
                left: 5,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
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
                  daysBetween(landPlanning.date_created,DateTime.now()) >0 ?daysBetween(landPlanning.date_created,DateTime.now()).toString()+" ngày trước": "Hôm nay",
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
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

}