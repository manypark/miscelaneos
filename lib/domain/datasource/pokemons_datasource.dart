import 'package:miscelaneos/domain/domain.dart';

abstract class PokemonDatasource {

  Future<( Pokemon?, String )> getPokemon(String id);
  
}
