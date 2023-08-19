import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AccelerometerScreen  extends ConsumerWidget {

  const AccelerometerScreen ({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final accelerometer$ = ref.watch( accelerometerGravityProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerómetro'),
      ),
      body: Center(
        child: accelerometer$.when(
          data    : (data) => Text(data.toString()), 
          error   : (error, _) => Text('$error'), 
          loading : () => const CircularProgressIndicator(),
        ),
      ),
    );
  }

}
