import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/sensors/magnemeter_provider.dart';

class MagnometerScreen extends ConsumerWidget {

  const MagnometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final magnemeter$ = ref.watch( magnetometerProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnometro'),
      ),
      body: Center(
        child:  magnemeter$.when(
          data    : (data) => Text(data.toString()), 
          error   : (error, _) => Text('$error'), 
          loading : () => const CircularProgressIndicator(),
        )
      ),
    );
  }

}
