import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:miscelaneos/presentation/providers/providers.dart';

class MapScreen extends ConsumerWidget {

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final currentLocationAsync =  ref.watch( userLocationProvider );

    return Scaffold(
      appBar: AppBar( title:  const Text('Map Screen') ),
      body: currentLocationAsync.when(
        data    : (data) => _MapView( initLat: data.$1, initLong: data.$2 ),
        error   : (error, stackTrace) => Text('$error'), 
        loading : () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }

}

class _MapView extends StatefulWidget {

  final double initLat;
  final double initLong;

  const _MapView({
    required this.initLat, 
    required this.initLong,
  });

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng( widget.initLat, widget.initLong),
        zoom  : 12,
      ),
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        // _controller.complete(controller);
      },
    );
  }
}