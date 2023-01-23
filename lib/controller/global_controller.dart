// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class GlobalController extends GetxController{
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble  getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;  

 @override
  void onInit() {
    // TODO: implement onInit
    if(_isLoading.isTrue){
       getLocation();
    }
   
    super.onInit();
  } 

  getLocation() async{
   bool isServiceEnabled= await Geolocator.isLocationServiceEnabled();
   LocationPermission locationPermission;

   if(!isServiceEnabled){
    return Future.error("Location not Enabled");
   }

   locationPermission = await Geolocator.checkPermission();

   if(locationPermission == LocationPermission.deniedForever){
      return Future.error("Location Permission is denied forever");
   }
   else if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied){
        return Future.error("Location Permission Denied");
      }
   }
  
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high).then((value){
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isLoading.value = false;
    });
  

  }

}

