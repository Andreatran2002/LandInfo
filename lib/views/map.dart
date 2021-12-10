import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/blocs/application_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
class Map extends StatefulWidget {
   Map({ required this.addPostFormKey});
  final GlobalKey<FormState> addPostFormKey ;
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  PermissionStatus? _status ;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(10.856809388642066, 106.77465589400319);
    Marker? _place;
  @override
  void initState() {
    super.initState();
    Permission.location.request();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  void dispose(){
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return  Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title : const Text("Bản đồ", style : TextStyle(color : Colors.white)),
          actions: [
            if (_place != null)
            TextButton(
              onPressed: ()=> mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: _place!.position,zoom : 15, tilt: 50.0),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle : const TextStyle(fontWeight: FontWeight.w600)
              ),
              child : const Text("Vị trí" , style : TextStyle(color : Colors.white)),
            ),
            TextButton(
              onPressed: ()=> {

              }
              ,
              style: TextButton.styleFrom(
                  primary: Colors.green,
                  textStyle : const TextStyle(fontWeight: FontWeight.w600)
              ),
              child : const Text("Tiếp" , style : TextStyle(color : Colors.white)),
            )
          ],
        ),
        body:GoogleMap(
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          markers: {
            if (_place != null) _place!
          },
          onLongPress: _addMarker,
          initialCameraPosition: CameraPosition(
            target: (applicationBloc.currentLocation == null) ? _center:
            LatLng(applicationBloc.currentLocation!.latitude, applicationBloc.currentLocation!.longitude),
            // target: _center,
            zoom: 14,
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: ()=> mapController.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: _center,zoom: 14)),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
      );
  }
  void _addMarker(LatLng pos){
      setState(()=>{
        _place = Marker(
          markerId: const MarkerId('place'),
          infoWindow: const InfoWindow(title: 'place'),
          icon : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos
        )
      } );

  }

}