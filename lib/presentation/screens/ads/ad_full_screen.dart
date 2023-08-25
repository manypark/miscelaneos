import 'package:flutter/material.dart';

class AdFullScreen extends StatelessWidget {
  
  const AdFullScreen({super.key});  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad full Screen'),
      ),
      body: const Center(
        child: Text('Ya puedes regresar o ver esta pantalla'),
      ),
    );
  }

}
