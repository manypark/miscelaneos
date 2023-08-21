import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/datasource/pokemons_datasource_impl.dart';

class PokemonsRepositoryIpml implements PokemonsRepository {

  final PokemonsDatasource datasource;

  PokemonsRepositoryIpml( {PokemonsDatasource? datasource} ) : datasource = datasource ?? PokemonsDatasourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return  datasource.getPokemon(id);
  }
  
}
