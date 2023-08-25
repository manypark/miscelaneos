import 'package:flutter/material.dart';
import 'package:miscelaneos/presentation/providers/background_tasks/background_tasks_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/domain/domain.dart';

class DbPokemonsScreen extends ConsumerWidget {

  const DbPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final pokemonAsync = ref.watch(pokemonDbProvider);
    final isBackgroundFetchActive = ref.watch( backgroundFetchProvider );

    if( pokemonAsync.isLoading ) return const Scaffold( body: Center( child: CircularProgressIndicator.adaptive() ) );

    final List<Pokemon> pokemons = pokemonAsync.value ?? [];

    return Scaffold(
      appBar: AppBar( 
        title: const Text('Background Process'),
        actions: [

          IconButton(
            onPressed : () {
              Workmanager().registerOneOffTask(
                fetchBackgroundTaskKey,
                fetchBackgroundTaskKey,
                initialDelay: const Duration( seconds: 5 ),
                inputData:  { 'pokemonInsert': true },
              );
            }, 
            icon      : const Icon( Icons.add_alarm_sharp)
          ),

        ],
      ),
      body: CustomScrollView(
        slivers: [
          _PokemonsGrid( pokemons: pokemons ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read( backgroundFetchProvider.notifier ).toggleProcess();
        },
        label : (isBackgroundFetchActive == true ) ? const Text('Desactivar fetch periodico') : const Text('Activar fetch periodico'),
        icon  : const Icon( Icons.av_timer )
      ),
    );
  }

}

class _PokemonsGrid extends StatelessWidget {

  final List<Pokemon> pokemons;

  const _PokemonsGrid({
    required this.pokemons,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount  : 3,
        crossAxisSpacing: 2,
        mainAxisSpacing : 2
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        
        final pokemon = pokemons[index];

        return Column(
          children: [

            Image.network(pokemon.spritefront,
            fit: BoxFit.contain,),

            Text( pokemon.name ),
          ],
        );
      },
    );
  }
}
