import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PokemonScreen extends ConsumerWidget {

  final String pokemonId;

  const PokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, ref) {

    final pokemonAsync = ref.watch( pokemonProvider(pokemonId) );

    return pokemonAsync.when(
      data    : (pokemon) => _PokemonView(pokemon: pokemon),
      error   : (error, stackTrace) => _ErrorWidget(msgError: error.toString()),
      loading : () => const LoadingWidget()
    );
  }

}


class _PokemonView extends StatelessWidget {

  final Pokemon pokemon;

  const _PokemonView({ required this.pokemon });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text( pokemon.name ),
        actions: [

          IconButton(
            icon     : const Icon( Icons.share_outlined ),
            onPressed: () {
              SharePlugin.shareLink( pokemon.spritefront, 'Mira este pokemon !');
            },
          ),
        ],
      ),
      body: Center(
        child: Image.network( 
          pokemon.spritefront,
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {

  final String msgError;

  const _ErrorWidget({ required this.msgError});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(msgError),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {

  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}