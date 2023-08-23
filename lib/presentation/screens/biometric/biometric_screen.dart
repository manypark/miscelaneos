import 'package:flutter/material.dart';

class BiometricScreen extends StatelessWidget {

  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children         : [

            FilledButton.tonal(
              onPressed: (){},
              child: const Text('Autenticar', style: TextStyle( fontSize: 20 ) )
            ),

            //TODO Feedback del proceso

            const SizedBox( width: 30 ),

            const Text('Estado del biometrico', style: TextStyle( fontSize: 30 ) ),

            const Text('Estado: XXX', style: TextStyle( fontSize: 30 ) ),

          ],
        ),
      ),
    );
  }

}
