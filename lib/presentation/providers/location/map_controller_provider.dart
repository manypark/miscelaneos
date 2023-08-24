import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final mapControllerProvider = StateNotifierProvider<MapNotifier, MapState>((ref) {
  return MapNotifier();
});

class MapNotifier extends StateNotifier<MapState> {

  MapNotifier():super( MapState() );

  void setMapController( GoogleMapController controller ) {
    state = state.copyWith( controller: controller, isReady: true );
  }

  goToLocation( double lat, double long ) {
    final newPosition = CameraPosition(
      target: LatLng( lat, long),
      zoom  : 15
    );

    state.controller?.animateCamera( CameraUpdate.newCameraPosition(newPosition) );
  }
  
}

class MapState {

  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  GoogleMapController? controller;

  MapState({
    this.isReady = false,
    this.followUser = false,
    this.markers = const [],
    this.controller,
  });

  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady   : isReady    ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers   : markers    ?? this.markers,
      controller: controller ?? this.controller,
    );

  }

}
