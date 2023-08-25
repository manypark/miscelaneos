import 'package:miscelaneos/domain/domain.dart';

abstract class LocalDbDatasource {

  Future<List<Pokemon>> localPokemons();
  Future<int> pokemonsCount();
  Future<void> addPokemon( Pokemon pokemon );
  
}
