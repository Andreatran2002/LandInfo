import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/blocs/application_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  PermissionStatus? _status ;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(10.856809388642066, 106.77465589400319);
  @override
  void initState() {
    super.initState();
    Permission.location.request();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return  Scaffold(
        // appBar: AppBar(
        //   title: const Text('Maps Sample App', style : TextStyle(color : Colors.white)),
        //   backgroundColor: Colors.green[700],
        // ),
        body:
        // (applicationBloc.currentLocation == null) ? Text("meo moe"):
        ListView(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm "
              ),
            ),
            Container(
              height: 300,
              child:  GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: (applicationBloc.currentLocation == null) ? _center:
                  LatLng(applicationBloc.currentLocation!.latitude, applicationBloc.currentLocation!.longitude),
                  // target: _center,
                  zoom: 14,
                ),
              )
            )
          ],
        ),
      );
  }

}