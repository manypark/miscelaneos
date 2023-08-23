import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {

  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final locationAsync       = ref.watch(userLocationProvider);
    final watchLocationAsync  = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar( title:  const Text('Ubicación') ),
      body: Center(
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children          : [

            const Text('Ubicacion actual', style: TextStyle(fontSize: 24),),

            locationAsync.when(
              data    : (data) => Text('$data'),
              error   : (error, stackTrace) => Text('$error'),
              loading : () => const CircularProgressIndicator.adaptive(),
            ),

            const SizedBox( height: 30,),

            const Text('Seguimiento de ubicacion', style: TextStyle(fontSize: 24)),

            watchLocationAsync.when(
              data    : (data) => Text('$data'),
              error   : (error, stackTrace) => Text('$error'),
              loading : () => const CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
  }

}
