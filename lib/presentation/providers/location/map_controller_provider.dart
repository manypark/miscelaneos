import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final mapControllerProvider = StateNotifierProvider.autoDispose<MapNotifier, MapState>((ref) {
  return MapNotifier();
});

class MapNotifier extends StateNotifier<MapState> {

  StreamSubscription? userLocationSubs;
  ( double, double )? lastKnowLocation;

  MapNotifier():super( MapState() ) {

    trackUser().listen((event) {
      lastKnowLocation = ( event.$1, event.$2 );
    });
  }

  Stream<( double, double )> trackUser() async* {

    await for( final pos in Geolocator.getPositionStream() ) {
      yield ( pos.latitude, pos.longitude );
    }
  }

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

  toggleFollowUser() {

    state = state.copyWith( followUser: !state.followUser );

    if( state.followUser ) {

      findUser();

      userLocationSubs = trackUser().listen((event) {
        goToLocation( event.$1, event.$2);
      });
      return;
    } 

    userLocationSubs?.cancel();
  }

  findUser() {

    if( lastKnowLocation == null ) return;

    final ( lat, long ) = lastKnowLocation!;

    goToLocation( lat, long );

    // trackUser().take(1).listen((event) {
    //   goToLocation(event.$1, event.$2);
    // });
  }

  void addMarkerCurrentPosition() {

    if(lastKnowLocation == null ) return;

    final ( lat, long ) = lastKnowLocation!;
      addMarker(lat, long, 'Por aqui paso el user');
  }

  void addMarker( double lat, double long, String name ) {

    final newMarker = Marker(
      markerId: MarkerId('${ state.markers.length }'),
      position: LatLng( lat, long ),
      infoWindow: InfoWindow(
        title : name,
        snippet: 'El snippet'
      )
    );


    state = state.copyWith( markers: [ ...state.markers, newMarker ] );
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

  Set<Marker> get markerSet {
    return Set.from(markers);
  }

  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) => MapState(
    isReady   : isReady    ?? this.isReady,
    followUser: followUser ?? this.followUser,
    markers   : markers    ?? this.markers,
    controller: controller ?? this.controller,
  );

}
