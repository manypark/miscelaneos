import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {

  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final gryscope$ = ref.watch( gyroscopeProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscopio de bola'),
      ),
      body: SizedBox.expand(
        child: gryscope$.when(
          data    : (data) => MovingBall( x: data.x, y: data.y),
          error   : (error, stackTrace) => Text('$error'), 
          loading : () => const CircularProgressIndicator()
        ),
      )
    );
  }

}


class MovingBall extends StatelessWidget {

  final double x;
  final double y;

  const MovingBall({
    super.key, 
    required this.x, 
    required this.y
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [

        AnimatedPositioned(
          duration: const Duration( milliseconds: 1000 ),
          curve   : Curves.bounceIn,
          left    : ( (y * 150) - 25 ) + (size.width / 2),
          top     : ( (x * 150) - 25 ) + (size.height / 2),
          child   : const Ball(),
        ),

        Text('''
          x: $x,
          y: $y,
        ''', style: const TextStyle( fontSize: 30 ) ),

      ],
    );
  }

}

class Ball extends StatelessWidget {

  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width : 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue
      ),
    );
  }

}
