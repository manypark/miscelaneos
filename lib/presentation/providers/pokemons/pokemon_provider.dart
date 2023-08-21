import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/infrastructure.dart';

final pokemonRepositoryProvider = Provider<PokemonsRepository>((ref) {
  return PokemonsRepositoryIpml();
});

final pokemonProvider = FutureProvider.family<Pokemon, String>( (ref, id) async {

  final pokemonRepository = ref.watch(pokemonRepositoryProvider);

  final ( pokemon, msgError ) = await pokemonRepository.getPokemon(id);

  if( pokemon != null ) return pokemon;

  throw msgError;
  
});
