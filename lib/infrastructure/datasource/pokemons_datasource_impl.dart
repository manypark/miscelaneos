import 'package:dio/dio.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/mappers/pokemon_mappers.dart';

class PokemonsDatasourceImpl implements PokemonsDatasource {

  final Dio dio;

  PokemonsDatasourceImpl(): dio = Dio(
    BaseOptions( baseUrl: 'https://pokeapi.co/api/v2' )
  );

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    
    try {
      
      final resp = await dio.get('/pokemon/$id');

      final pokemon  = PokemonMapper.pokeApiPokemonToEntitiy(resp.data);

      return ( pokemon, 'Data obtenida correctamente');

    } catch (e) {
      return ( null, 'No se pudo obtener le pokemon $e');  
    }

  }
  
}