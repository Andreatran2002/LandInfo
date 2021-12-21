import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' ;
import 'Dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;
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

    // final Bitmap bitmap = Bitmap.fromAssetImage(image);
    // BitmapDescriptor.fromAssetImage(
    //     const ImageConfiguration(devicePixelRatio: 2.5,size: Size(10, 10)), 'assets/images/binhthuanland.png')
    //     .then((onValue) {
    //   myIcon = onValue;
    // });
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
                zoom: 14,
              ),
              markers: markers,
              onLongPress:  (pos) async {
                print(pos);
                print("he");
                final icon = await getBitmapDescriptorFromAssetBytes('assets/images/binhthuanland.png', 1000);

                MediaQueryData mediaQueryData = MediaQuery.of(context);
                ImageConfiguration imageConfig = ImageConfiguration(devicePixelRatio: mediaQueryData.devicePixelRatio);
                final Uint8List markerIcon = await getBytesFromAsset('assets/images/binhthuanland.png',1000 );
                final Marker marker = Marker(icon: icon, position: pos,markerId: MarkerId(pos.toString()));

                setState(() {
                  markers.add(marker);
                });

              },

            ),

          ),

        )
    );

  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }
}
