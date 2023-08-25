import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/datasource/isar_local_db_datasource.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {

  final LocalDbDatasource _datasource;

  LocalDbRepositoryImpl(
    [ LocalDbDatasource? datasource ]
  ) : _datasource = datasource ?? IsarLocalDbDatasource() ;

  @override
  Future<void> addPokemon(Pokemon pokemon) {
    return _datasource.addPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _datasource.loadPokemons();
  }

  @override
  Future<int> pokemonsCount() {
    return _datasource.pokemonsCount();
  }
  
}
