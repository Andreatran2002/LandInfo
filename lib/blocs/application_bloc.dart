import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tineviland/utils/geolocator_service.dart';

class ApplicationBloc with ChangeNotifier  {
  final  geoLocatorService = GeolocatorService();

  ApplicationBloc(){
    setCurrentLocation();
    pickLocation();
  }
  //Variables
  Position? currentLocation  ;
  Position? location;
  pickLocation() async{

  }
  setCurrentLocation() async  {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

}
