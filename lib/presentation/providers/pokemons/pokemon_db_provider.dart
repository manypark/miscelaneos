import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/infrastructure.dart';

final pokemonDbProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) async {

  final localDB   = LocalDbRepositoryImpl();
  final pokemons  = await localDB.loadPokemons();

  return pokemons;
});