import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/blocs/application_bloc.dart';
class DetailLandPlanning extends StatefulWidget {
  const DetailLandPlanning({Key? key}) : super(key: key);

  @override
  _DetailLandPlanningState createState() => _DetailLandPlanningState();
}

class _DetailLandPlanningState extends State<DetailLandPlanning> {

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/binhthuanland.png')
        .then((onValue) {
      myIcon = onValue;
    });
  }
  late GoogleMapController mapController;
  BitmapDescriptor? myIcon ;
  late Set<Marker> markers;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
    @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
        body: Container(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(10.856809388642066, 106.77465589400319),
              ),
              markers: markers,
              onLongPress:  (pos) {
                print(pos);
                print("he");
                Marker f =
                Marker(markerId: MarkerId(pos.toString()), icon: myIcon!, position: pos,
                    onTap: (){});
                setState(() {
                  markers.add(f);
                });

              },

            ),

          ),

        )
    );

  }
}
