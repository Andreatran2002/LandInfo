import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tineviland/models/land_planing.dart';
import 'package:latlong2/latlong.dart';
import 'detail_map_land_planning.dart';


class LandPlanningPage extends StatefulWidget {
  const LandPlanningPage({Key? key}) : super(key: key);

  @override
  _LandPlanningPageState createState() => _LandPlanningPageState();
}

class _LandPlanningPageState extends State<LandPlanningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar : AppBar(
          title: Text("Quy hoạch", style : TextStyle(color : Colors.white)),

        ),
        body :Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('landPlannings').snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print("hello" + snapshot.error.toString());
                  return Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
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
                      child: LandPlanningCard(
                        landPlanning: landPlanning,
                      ),
                    );
                  },
                );
              }),
        ),
    );
  }
}


class LandPlanningCard extends StatefulWidget {
  LandPlanningCard({
    Key? key,
    required this.landPlanning
  }) : super(key: key);

  final LandPlanning landPlanning;
  @override
  State<LandPlanningCard> createState() => _LandPlanningCardState();
}

class _LandPlanningCardState extends State<LandPlanningCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding : EdgeInsets.all(16),
      width: 300 ,
      height: 150,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 5,
              spreadRadius: 1.1,
            )
          ]),
      child: Row(
        children: [
          Container(
            width:90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              image: DecorationImage(
                scale : 2.0,
                image: NetworkImage(widget.landPlanning.mapUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: FadeInImage.assetNetwork(
                // fadeInCurve: Curves.bounceIn,
                fadeInDuration: Duration(
                  milliseconds: 500,
                ),
                placeholder: 'assets/images/loading.gif',
                image: widget.landPlanning.imageUrl,
                fit: BoxFit.cover,
                width: 180,
              ),
            ),
          ),
          const SizedBox(width : 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.landPlanning.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(widget.landPlanning.isValidated ? "Tình trạng:  Còn hiệu lực": "Tình trạng: Mất hiệu lực", style : TextStyle(color : Theme.of(context).colorScheme.primary)),
                  Flexible(
                    child: Text(
                      widget.landPlanning.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: 12,
                      ),
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
