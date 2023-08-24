import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {

  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final userInitialLocation = ref.watch( userLocationProvider );
    // final followUserLocation = ref.watch( watchLocationProvider );

    return Scaffold(
      body: userInitialLocation.when(
        data   : (data) => MapAndControls(latitud: data.$1, longitud:  data.$2),
        error  : (error, stackTrace) => Text('$error'),
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              Text('Ubicando usuario'),
              SizedBox( height: 30,),
              CircularProgressIndicator.adaptive()
            ],
          ),
        ),
      ),
    );
  }

}

class MapAndControls extends ConsumerWidget {

  final double latitud;
  final double longitud;

  const MapAndControls({
    super.key, 
    required this.latitud, 
    required this.longitud,
  });

  @override
  Widget build(BuildContext context, ref) {

    final mapController = ref.watch( mapControllerProvider );

    return Stack(
      children: [

        _MapView( latitud: latitud, longitud:longitud ),

        Positioned(
          top   : 40,
          left  : 20,
          child : IconButton.filled(
            onPressed: () => context.pop(),
            icon     : const Icon( Icons.arrow_back )
          )
        ),

        // go position user
        Positioned(
          bottom: 40,
          left  : 20,
          child : IconButton.filled(
            onPressed: () {
              ref.read( mapControllerProvider.notifier ).findUser();
            },
            icon     : const Icon( Icons.location_searching )
          )
        ),

        Positioned(
          bottom: 90,
          left  : 20,
          child : IconButton.filled(
            onPressed: () {
              ref.read( mapControllerProvider.notifier ).toggleFollowUser();
            },
            icon : Icon( mapController.followUser ? Icons.directions_run : Icons.accessibility_new_outlined )
          )
        ),

        Positioned(
          bottom: 140,
          left  : 20,
          child : IconButton.filled(
            onPressed: () {
              ref.read( mapControllerProvider.notifier ).addMarkerCurrentPosition();
            },
            icon     : const Icon( Icons.pin_drop )
          )
        ),

      ],
    );
  }

}

class _MapView extends ConsumerStatefulWidget {

  final double latitud;
  final double longitud;

  const _MapView({
    required this.latitud, 
    required this.longitud,
  });

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<_MapView> {

  @override
  Widget build(BuildContext context) {

  final mapController = ref.watch( mapControllerProvider );

    return GoogleMap(
      markers                 : mapController.markerSet,
      initialCameraPosition   : CameraPosition(
        target: LatLng( widget.latitud, widget.longitud), zoom : 12,
      ),
      mapType                 : MapType.normal,
      myLocationEnabled       : true,
      zoomControlsEnabled     : false,
      myLocationButtonEnabled : false,
      onMapCreated            : (GoogleMapController controller) {
        ref.read( mapControllerProvider.notifier ).setMapController(controller);
      },
      onLongPress: (argument) {
        ref.read( mapControllerProvider.notifier ).addMarker( argument.latitude, argument.longitude, 'Custom Market' );
      },
    );
  }
  
}
