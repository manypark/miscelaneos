import 'package:miscelaneos/domain/domain.dart';

abstract class LocalDbRepository {

  Future<List<Pokemon>> loadPokemons();
  Future<int> pokemonsCount();
  Future<void> addPokemon( Pokemon pokemon );
  
}
