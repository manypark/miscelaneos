import 'package:miscelaneos/domain/domain.dart';

abstract class LocalDbRepository {

  Future<List<Pokemon>> localPokemons();
  Future<int> pokemonsCount();
  Future<void> addPokemon( Pokemon pokemon );
  
}
