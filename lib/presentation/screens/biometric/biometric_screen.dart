import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {

  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final canCheckBiometris = ref.watch( canCheckBiometricsProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children          : [

            FilledButton(
              onPressed: (){},
              child: const Text('Autenticar', style: TextStyle( fontSize: 20 ) )
            ),

            const SizedBox( height: 30 ),

            canCheckBiometris.when(
              data    : (canCheck) => Text('Puede implementar biometrics: $canCheck'),
              error   : (error, stackTrace) => Text('Error: $error'), 
              loading : () => const CircularProgressIndicator.adaptive()
            ),

            const SizedBox( height: 30 ),

            const Text('Estado del biometrico', style: TextStyle( fontSize: 24 ) ),

            const Text('Estado: XXX', style: TextStyle( fontSize: 24 ) ),

          ],
        ),
      ),
    );
  }

}
