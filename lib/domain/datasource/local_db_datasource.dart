import 'package:miscelaneos/domain/domain.dart';

abstract class LocalDbDatasource {

  Future<List<Pokemon>> loadPokemons();
  Future<int> pokemonsCount();
  Future<void> addPokemon( Pokemon pokemon );
  
}
