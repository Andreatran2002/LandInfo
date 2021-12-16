import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tineviland/models/post.dart';
import 'package:tineviland/models/user.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
  String _address = "";
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
          title: const Text(
            "Chi tiết",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.post.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.post.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(""),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Ngày đăng : ${widget.post.date_created.day.toString()}/${widget.post.date_created.month.toString()}/${widget.post.date_created.year.toString()}",
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "Montserrat",
                                    fontSize: 13,
                                  ),
                        ),
                      ),
                    ],
                  ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
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
                              width: 10,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.post.price.toString() + " tr",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    fontSize: 15,
                                  ),
                            ),
                          ]),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 25,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
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
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await FlutterPhoneDirectCaller.callNumber(
                          author.PhoneNumber);
                    },
                    icon: Icon(Icons.phone),
                    label: Text("Liên lạc ngay"),
                  )
                  //
                ],
              ),
              const SizedBox(height: 10),
              Container(
                child: Text(
                  widget.post.content,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              const Divider(
                height: 25,
                thickness: 1,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icons/area.svg",
                        color: Colors.black,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Diện tích : " +
                            widget.post.surfaceArea.toString() +
                            " m²",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/money.svg",
                      width: 10,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Giá : " + widget.post.price.toString() + " tr",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/locate.svg",
                          width: 10,
                          color: Colors.green,
                        ),
                        SizedBox(width: 11),
                        Expanded(
                          child: Text(
                            "Vị trí : " + _address,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                    ),
                          ),
                        ),
                      ]),
                ]),
              ),
              const SizedBox(height: 20),
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
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: GoogleMap(
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  mapType: MapType.hybrid,
                  markers: {if (_place != null) _place!},
                  initialCameraPosition: CameraPosition(
                    target: _center!,
                    // target: _center,
                    zoom: 14,
                  ),
                ),
              ),
              const SizedBox(height: 35)
            ],
          ),
        ));
  }

  Future<void> takeAuthorInfo() async {
    User author1 = await AuthMethods.getUser(widget.post.author_id);
    setState(() => {author = author1});
  }

  Widget authorInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        author != null ? author.Name : "",
        style: const TextStyle(
            fontFamily: "Montserrat",
            wordSpacing: 2,
            fontWeight: FontWeight.w600,
            fontSize: 17),
      ),
      Text(
        author != null ? author.PhoneNumber : "",
        style: const TextStyle(
            fontFamily: "Montserrat",
            fontStyle: FontStyle.italic,
            wordSpacing: 2,
            fontSize: 13),
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
  }
}
