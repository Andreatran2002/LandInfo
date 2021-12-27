import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tineviland/models/land_planing.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailLandPlanning extends StatefulWidget {
  final LandPlanning landPlanning ;
  DetailLandPlanning({required this.landPlanning});

  @override
  _DetailLandPlanningState createState() => _DetailLandPlanningState();
}

class _DetailLandPlanningState extends State<DetailLandPlanning> {
  MapController mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle : true,
        title: Text("Chi tiết", style: TextStyle(color : Colors.white) ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.article),
          ),
        ],
      ),
      body: FlutterMap(
        nonRotatedLayers: const [],
        options: MapOptions(
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          zoom: 12.0, // Changed zoom level from 16 to 12, to better see the whole overlay area from further distance
          // center: LatLng(15,26)
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: widget.landPlanning.mapUrl,
              // "https://api.mapbox.com/styles/v1/andreatran2002/ckxjye6d2kw0p15o562zzeg4g/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ",
            // TODO: add access token here OR if you keep it in one line in `urlTemplate`, then delete `additionalOptions`.
            additionalOptions: {
             'accessToken' : widget.landPlanning.accessToken
              // 'accessToken': 'pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ',
            },
          ),
        ],
        mapController: mapController,
      ),
    );
  }

}