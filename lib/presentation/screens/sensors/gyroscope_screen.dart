import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeScreen extends ConsumerWidget {

  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final gryoscope$ = ref.watch( gyroscopeProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscopio'),
      ),
      body: Center(
        child: gryoscope$.when(
          data    : (data) => Text(data.toString()), 
          error   : (error, _) => Text('$error'), 
          loading : () => const CircularProgressIndicator(),
        ),
      ),
    );
  }

}
