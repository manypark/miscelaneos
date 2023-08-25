import 'package:flutter/material.dart';

class AdRewardedScreen extends StatelessWidget {
  
  const AdRewardedScreen({super.key});  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Rewarded'),
      ),
      body: const Center(
        child: Text('Puntos actuales: '),
      ),
    );
  }

}
