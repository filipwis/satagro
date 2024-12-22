import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@module
abstract class ServiceModule {
  Permission get permission => Permission.locationWhenInUse;
  GeolocatorPlatform get geolocator => GeolocatorPlatform.instance;
}
