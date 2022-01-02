import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tineviland/models/land_planing.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'detail_land_planning.dart';

class DetailMapLandPlanning extends StatefulWidget {
  final LandPlanning landPlanning ;
  const DetailMapLandPlanning({required this.landPlanning});

  @override
  _DetailMapLandPlanningState createState() => _DetailMapLandPlanningState();
}

class _DetailMapLandPlanningState extends State<DetailMapLandPlanning> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
              centerTitle : true,
              title: const Text("Bản đồ quy hoạch", style: TextStyle(color : Colors.white) ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailLandPlanning(landPlanning: widget.landPlanning,)));

                  },
                  icon: const Icon(Icons.article, color: Colors.white,),
                ),

              ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded , color: Colors.white,),),
            ),
      body: Column(
        children: [
          Flexible(
            child: Expanded(
            child: WebView(
              initialUrl: 'about:blank',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) async {
                _controller = webViewController;
                 await _loadHtmlFromAssets();
              },
            ),
        ),
          ),
        ]
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileText ='''
  <!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>Add a raster image to a map layer</title>
		<meta
			name="viewport"
			content="initial-scale=1,maximum-scale=1,user-scalable=no"
		/>
		<link
			href="https://api.mapbox.com/mapbox-gl-js/v2.6.1/mapbox-gl.css"
			rel="stylesheet"
		/>
		<script src="https://api.mapbox.com/mapbox-gl-js/v2.6.1/mapbox-gl.js"></script>
		<style>
			body {
				margin: 0;
				padding: 0;
			}
			#map {
				position: absolute;
				top: 0;
				bottom: 0;
				width: 100%;
				object-fit: cover;
			}
			#map > img {
				transform: scale(1.6);
			}
		</style>
	</head>
	<body>
		<div id="map"></div>
		<script>
			// TO MAKE THE MAP APPEAR YOU MUST
			// ADD YOUR ACCESS TOKEN FROM
			// https://account.mapbox.com
			mapboxgl.accessToken =
				'${widget.landPlanning.accessToken}'

			const map = new mapboxgl.Map({
				container: 'map',
				zoom: 7,
				center: [${widget.landPlanning.rightBotton.longitude}, ${widget.landPlanning.rightBotton.latitude}],
				style: 'mapbox://styles/andreatran2002/ckxuiyic394hv16ryg9jx3jb7',
			})
			// disable map rotation using right click + drag
			map.dragRotate.disable()

			// disable map rotation using touch rotation 7
			 map.touchZoomRotate.disableRotation()
			map.on('load', () => {
				map.addSource('radar', {
					type: 'image',
					url: '${widget.landPlanning.imageUrl}',
					coordinates: [
						[${widget.landPlanning.leftTop.longitude}, ${widget.landPlanning.leftTop.latitude}],
						[${widget.landPlanning.rightTop.longitude}, ${widget.landPlanning.rightTop.latitude}],
						[${widget.landPlanning.rightBotton.longitude}, ${widget.landPlanning.rightBotton.latitude}],
						[${widget.landPlanning.leftBotton.longitude}, ${widget.landPlanning.leftBotton.latitude}],
					],
				})
				map.addLayer({
					id: 'radar-layer',
					type: 'raster',
					source: 'radar',

					paint: {
						'raster-fade-duration': 0,
						'raster-opacity': 0.8,
					},
				})
			})
		</script>
	</body>
</html>
  ''';
    _controller.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }


  // MapController mapController = MapController();
  // LatLng? _center;
  // get landPlanning => widget.landPlanning;
  // @override
  // Widget build(BuildContext context) {
  //   _center = widget.landPlanning.center;
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle : true,
  //       title: const Text("Bản đồ quy hoạch", style: TextStyle(color : Colors.white) ),
  //       leading: IconButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         icon: const Icon(Icons.arrow_back_rounded , color: Colors.white,),
  //       ),
  //       actions: [
  //         IconButton(
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => DetailLandPlanning(landPlanning: landPlanning,)));
  //
  //           },
  //           icon: const Icon(Icons.article, color: Colors.white,),
  //         ),
  //       ],
  //     ),
  //     body: FlutterMap(
  //       nonRotatedLayers: const [],
  //       options: MapOptions(
  //         interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
  //         zoom: 9.0, // Changed zoom level from 16 to 12, to better see the whole overlay area from further distance
  //          center: _center,
  //       ),
  //       layers: [
  //          TileLayerOptions(
  //           urlTemplate: widget.landPlanning.mapUrl,
  //             // "https://api.mapbox.com/styles/v1/andreatran2002/ckxjye6d2kw0p15o562zzeg4g/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ",
  //           // TODO: add access token here OR if you keep it in one line in `urlTemplate`, then delete `additionalOptions`.
  //           additionalOptions: {
  //            'accessToken' : widget.landPlanning.accessToken
  //             // 'accessToken': 'pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ',
  //           },
  //         ),
  //       ],
  //       mapController: mapController,
  //     ),
  //   );
  // }

}