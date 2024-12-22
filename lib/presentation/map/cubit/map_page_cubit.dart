import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'map_page_state.dart';

@injectable
class MapPageCubit extends Cubit<MapPageState> {
  MapPageCubit(
    this._permission,
    this._geolocator,
  ) : super(MapPageLoading());

  final Permission _permission;
  final GeolocatorPlatform _geolocator;

  LatLng? _position;
  Set<Polygon> _polygons = {};
  Set<Marker> _markers = {};

  Future<void> init() async {
    if (await _permission.isGranted || await _permission.request().isGranted) {
      if (!await _geolocator.isLocationServiceEnabled()) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

      _position = LatLng(
        position.latitude,
        position.longitude,
      );
    }

    _emitIdle();
  }

  void _emitIdle() {
    emit(
      MapPageIdle(
        position: _position,
        polygons: _polygons,
        markers: _markers,
        isCreatingPolygonMode: _markers.isNotEmpty,
      ),
    );
  }

  void drawPolygon(LatLng point) {
    final Set<Marker> fromMarkers = Set.from(_markers);
    fromMarkers.add(
      Marker(
        markerId: MarkerId('${point.latitude}${point.longitude}'),
        position: point,
      ),
    );
    _markers = fromMarkers;

    _emitIdle();
  }

  void deleteLastPoint() {
    final List<Marker> fromMarkers = List.from(_markers);

    fromMarkers.removeLast();
    _markers = fromMarkers.toSet();

    _emitIdle();
  }

  void submitPolygon() {
    final Set<Polygon> fromPolygons = Set.from(_polygons);

    final polygonId = DateTime.now().millisecond.toString() +
        _markers.first.position.latitude.toString();

    double latSum = 0;
    double lngSum = 0;

    final points = _markers.map((marker) => marker.position).toList();

    for (var point in points) {
      latSum += point.latitude;
      lngSum += point.longitude;
    }

    final centroid = LatLng(latSum / _markers.length, lngSum / _markers.length);

    points.sort((a, b) {
      final angleA = atan2(
          a.latitude - centroid.latitude, a.longitude - centroid.longitude);
      final angleB = atan2(
          b.latitude - centroid.latitude, b.longitude - centroid.longitude);
      return angleA.compareTo(angleB);
    });

    fromPolygons.add(
      Polygon(
        polygonId: PolygonId(polygonId),
        points: points,
        strokeWidth: 5,
        fillColor: Colors.green.withValues(alpha: 0.2),
      ),
    );

    _polygons = fromPolygons;

    _markers.clear();

    _emitIdle();
  }
}
