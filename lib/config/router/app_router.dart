import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/screens/screens.dart';

final appRouter = GoRouter(

  initialLocation : '/',
  routes          : [

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionScreen(),
    ),

    //Sensors
    GoRoute(
      path: '/gyroscope',
      builder: (context, state) => const GyroscopeScreen(),
    ),

    GoRoute(
      path: '/accelerometer',
      builder: (context, state) => const AccelerometerScreen(),
    ),

    GoRoute(
      path: '/magnetometer',
      builder: (context, state) => const MagnometerScreen(),
    ),

    GoRoute(
      path: '/gyroscope-ball',
      builder: (context, state) => const GyroscopeBallScreen(),
    ),

    GoRoute(
      path: '/compass',
      builder: (context, state) => const CompassScreen(),
    ),

    GoRoute(
      path: '/pokemons',
      builder: (context, state) => const PokemonsScreen(),
      routes: [

        GoRoute(
          path   : ':id',
          builder: (context, state) {

            final idPokemon = state.pathParameters['id'] ?? '1';

            return PokemonScreen( pokemonId: idPokemon );
          },
        ),

      ]
    ),

    GoRoute(
      path: '/biometrics',
      builder: (context, state) => const BiometricScreen(),
    ),

    // Ubicacion y mapas
    GoRoute(
      path: '/location',
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      path: '/maps',
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: '/controlled-map',
      builder: (context, state) => const ControlledMapScreen(),
    ),

    GoRoute(
      path: '/badge',
      builder: (context, state) => const BadgeScreen(),
    ),

  ]

);
