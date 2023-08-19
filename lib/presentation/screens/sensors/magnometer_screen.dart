import 'package:flutter/material.dart';

class MagnometerScreen extends StatelessWidget {

  const MagnometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnometro'),
      ),
      body: const Center(
        child: Text('Hola manu'),
      ),
    );
  }

}
