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

  ]

);
