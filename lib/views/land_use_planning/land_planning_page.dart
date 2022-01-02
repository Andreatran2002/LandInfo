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
          title: const Text("Quy hoạch", style : TextStyle(color : Colors.white)),

        ),
        body :Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('landPlannings').snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print("hello" + snapshot.error.toString());
                  return const Text("something is wrong");
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

                    final LandPlanning landPlanning = LandPlanning(
                        title:  snapshot.data!.docs[index].get('title'),
                        content: snapshot.data!.docs[index].get('content'),
                        date_created: snapshot.data!.docs[index].get('dateCreated').toDate(),
                        accessToken: snapshot.data!.docs[index].get('accessToken'),
                        isValidated: snapshot.data!.docs[index].get('isValidated'),
                        mapUrl: snapshot.data!.docs[index].get('mapUrl'),
                        imageUrl: snapshot.data!.docs[index].get('imageUrl'),
                      leftTop:  LatLng(snapshot.data!.docs[index].get('leftTop').latitude, snapshot.data!.docs[index].get('leftTop').longitude),
                      rightTop:  LatLng(snapshot.data!.docs[index].get('rightTop').latitude, snapshot.data!.docs[index].get('rightTop').longitude),
                      leftBotton:  LatLng(snapshot.data!.docs[index].get('leftBotton').latitude, snapshot.data!.docs[index].get('leftBotton').longitude),
                      rightBotton:  LatLng(snapshot.data!.docs[index].get('rightBotton').latitude, snapshot.data!.docs[index].get('rightBotton').longitude),

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
      padding : const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width*0.9 ,
      height:MediaQuery.of(context).size.height*0.18,
      margin: const EdgeInsets.only(bottom: 20),
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
                  const SizedBox(height : 10),
                  Text(
                    "Ngày đăng : ${widget.landPlanning.date_created.day}/${widget.landPlanning.date_created.month}/${widget.landPlanning.date_created.year}",
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(

                        fontFamily: "Montserrat",
                        fontSize: 10,
                        fontStyle: FontStyle.italic
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
