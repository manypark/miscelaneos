import 'package:flutter/material.dart';

class GyroscopeBallScreen extends StatelessWidget {

  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscopio de bola'),
      ),
      body: const Center(
        child: Text('Hola manu'),
      ),
    );
  }

}
