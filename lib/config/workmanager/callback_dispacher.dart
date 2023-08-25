import 'package:workmanager/workmanager.dart';
import 'package:miscelaneos/infrastructure/infrastructure.dart';

const fetchBackgroundTaskKey = 'menu.dev.miscelaneo.fecth-background-pokemon';
const fetchPeriodicBackgroundTaskKey = 'menu.dev.miscelaneo.fecth-background-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    switch ( task ) {

      case fetchBackgroundTaskKey:
        await loadNextPokemon();
      break;

      case fetchPeriodicBackgroundTaskKey:
        print('fetchPeriodicBackgroundTaskKey');
      break;

      case Workmanager.iOSBackgroundTask:
       print('Workmanager.iOSBackgroundTask');
      break;
    }

    return true;
    // print("Native called background task: $task");
    // return Future.value(true);
  });

}

Future loadNextPokemon() async {

  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryIpml();

  final lastPokemonId = await localDbRepository.pokemonsCount() + 1;

  try {

    final ( pokemon, message ) = await pokemonRepository.getPokemon( '$lastPokemonId' );

    if( pokemon == null ) throw message;

    await localDbRepository.addPokemon(pokemon);
    print('Pokemon save: ${pokemon.name}');

  } catch (e) {
    print('$e');
  }

}