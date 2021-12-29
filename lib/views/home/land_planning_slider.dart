import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tineviland/models/land_planing.dart';
import 'package:tineviland/views/land_use_planning/detail_map_land_planning.dart';
import 'package:tineviland/views/land_use_planning/land_planning_page.dart';
import 'package:tineviland/Widgets/Cards/land_planning_slider_card.dart';
import 'package:latlong2/latlong.dart';
class LandPlanningSlider extends StatefulWidget {
  final String title;
  final String collectionName;
  const LandPlanningSlider({
    Key? key,
    required this.title,
    required this.collectionName,
  }) : super(key: key);
  @override
  _LandPlanningSliderState createState() => _LandPlanningSliderState();
}

class _LandPlanningSliderState extends State<LandPlanningSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LandPlanningPage(),
                    ),
                  );
                },
                child: Text(
                  "Xem thêm",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontFamily: "Montserrat",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 210.0,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection(widget.collectionName).snapshots(),
              builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                if (snapshot.hasError) {
                  return Text("something is wrong", style: TextStyle(color : Theme.of(context).colorScheme.error),);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length < 6 ? snapshot.data!.docs.length : 5 ,
                  itemBuilder: (BuildContext context, int index) {
                    GeoPoint geoPoint = snapshot.data!.docs[index].get('center');
                    double lat = geoPoint.latitude;
                    double lng = geoPoint.longitude;
                    final LandPlanning landPlanning = LandPlanning(
                        title:  snapshot.data!.docs[index].get('title'),
                        content: snapshot.data!.docs[index].get('content'),
                        date_created: snapshot.data!.docs[index].get('dateCreated').toDate(),
                        accessToken: snapshot.data!.docs[index].get('accessToken'),
                        isValidated: snapshot.data!.docs[index].get('isValidated'),
                        mapUrl: snapshot.data!.docs[index].get('mapUrl'),
                        imageUrl: snapshot.data!.docs[index].get('imageUrl'),
                        center:  LatLng(lat, lng)
                    );
                    return GestureDetector(
                      onTap: ()=>  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMapLandPlanning(landPlanning: landPlanning,))),
                      child: LandPlanningCardSlider(
                        landPlanning: landPlanning,
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
