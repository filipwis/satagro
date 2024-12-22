part of 'map_page_cubit.dart';

sealed class MapPageState {}

final class MapPageLoading extends MapPageState {}

final class MapPageIdle extends MapPageState {
  MapPageIdle({
    required this.isCreatingPolygonMode,
    required this.polygons,
    required this.markers,
    this.position,
  });

  final bool isCreatingPolygonMode;
  final LatLng? position;
  final Set<Polygon> polygons;
  final Set<Marker> markers;
}
