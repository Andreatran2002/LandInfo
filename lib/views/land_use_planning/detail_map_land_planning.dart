import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tineviland/models/land_planing.dart';
import 'detail_land_planning.dart';

class DetailMapLandPlanning extends StatefulWidget {
  final LandPlanning landPlanning ;
  const DetailMapLandPlanning({required this.landPlanning});

  @override
  _DetailMapLandPlanningState createState() => _DetailMapLandPlanningState();
}

class _DetailMapLandPlanningState extends State<DetailMapLandPlanning> {
  MapController mapController = MapController();
  LatLng? _center;
  get landPlanning => widget.landPlanning;
  @override

  @override
  Widget build(BuildContext context) {
    _center = widget.landPlanning.center;
    return Scaffold(
      appBar: AppBar(
        centerTitle : true,
        title: const Text("Bản đồ quy hoạch", style: TextStyle(color : Colors.white) ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded , color: Colors.white,),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailLandPlanning(landPlanning: landPlanning,)));

            },
            icon: const Icon(Icons.article, color: Colors.white,),
          ),
        ],
      ),
      body: FlutterMap(
        nonRotatedLayers: const [],
        options: MapOptions(
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          zoom: 9.0, // Changed zoom level from 16 to 12, to better see the whole overlay area from further distance
           center: _center,
        ),
        layers: [
           TileLayerOptions(
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