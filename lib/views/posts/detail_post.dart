import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/models/user.dart';
import 'package:tineviland/utils/authmethod.dart';

class DetailPost extends StatefulWidget {
  DetailPost({required this.post, Key? key}) : super(key: key);
  Post post;
  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  late GoogleMapController mapController;
  User author = User(Name: "", PhoneNumber: "", Password: "", ImageUrl: "");
  late LatLng? _center;
  Marker? _place;
  String _address ="";
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void initState() {
    super.initState();
    takeAuthorInfo();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _center = widget.post.coordinate;
    GetAddressFromLatLong(_center!);
    _place = Marker(
        markerId: const MarkerId('place'),
        infoWindow: const InfoWindow(title: 'Vị trí'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _center!);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title:
                const Text("Chi tiết", style: TextStyle(color: Colors.white))),
        body: ListView(
          padding: const EdgeInsets.only(left: 5, right: 5),
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                image: DecorationImage(
                  image: NetworkImage(widget.post.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(widget.post.title,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montsterrat')),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(children: [
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Ngày đăng : ${widget.post.date_created.day.toString()}/${widget.post.date_created.month.toString()}/${widget.post.date_created.year.toString()}",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Montserrat",
                          fontSize: 13,
                        ),
                  ),
                ),
                Text("")
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SvgPicture.asset("assets/icons/area.svg"),
                        const SizedBox(width: 8),
                        Text(
                          widget.post.surfaceArea.toString() + " m²",
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    fontSize: 15,
                                  ),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/money.svg",
                          width: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          widget.post.price.toString() + " tr",
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    fontSize: 15,
                                  ),
                        ),
                      ]),
                ],
              ),
            ]),
            const Divider(
              height: 25,
              thickness: 1,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            author.ImageUrl != ""
                                ? author.ImageUrl
                                : "https://firebasestorage.googleapis.com/v0/b/tinevyland.appspot.com/o/avatar%2Fdefault-avatar.png?alt=media&token=57c2019d-3687-4984-9bb4-42a7c30dea87",
                          ))),
                ),
                const SizedBox(
                  width: 10,
                ),
                authorInfo(),

                //
              ],
            ),
            SizedBox(height : 10),
            Container(padding: EdgeInsets.all(10),child: Text(widget.post.content,style: TextStyle(fontSize: 15))),
            const Divider(
              height: 25,
              thickness: 1,
            ),
            SizedBox(height : 20),
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children:[
                  Row(
                      children: <Widget>[
                        SvgPicture.asset("assets/icons/area.svg",color: Colors.black,),
                        const SizedBox(width: 8),
                        Text(
                          "Diện tích : "+widget.post.surfaceArea.toString() + " m²",
                          style:
                          Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 8),
                  Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/money.svg",
                          width: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Giá : "+widget.post.price.toString() + " tr",
                          style:
                          Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        SvgPicture.asset(
                          "assets/icons/locate.svg",
                          width: 13,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Vị trí : "+_address,
                            style:
                            Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ]),

                ]
              ),
            ),
            const SizedBox(height : 35),
            Container(
              height: 300,
              child: GoogleMap(
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                mapType: MapType.hybrid
                ,
                markers: {if (_place != null) _place!},
                initialCameraPosition: CameraPosition(
                  target: _center!,
                  // target: _center,
                  zoom: 14,
                ),
              ),
            ),


            const SizedBox(height : 35)
          ],
        ));
  }

  Future<void> takeAuthorInfo() async {
    User author1 = await AuthMethods.getUser(widget.post.author_id);
    setState(() => {author = author1});
  }

  Widget authorInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        author != null ? author.Name + "   " : "",
        style: const TextStyle(
            wordSpacing: 2, fontWeight: FontWeight.w500, fontSize: 17),
      ),
      Text(
        author != null ? author.PhoneNumber + "   " : "",
        style: const TextStyle(
            fontStyle: FontStyle.italic, wordSpacing: 2, fontSize: 13),
      ),
    ]);
  }
  void GetAddressFromLatLong(LatLng position) async {
    setState(() async {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];

      _address =
      '${place.subAdministrativeArea} ${place.locality} ${place.administrativeArea}';
    });
    print(_address);
    print("Địa chỉ đây nè -----------------------------------------------");
  }
}
