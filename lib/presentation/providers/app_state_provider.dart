import 'package:flutter/material.dart' show AppLifecycleState;
import 'package:flutter_riverpod/flutter_riverpod.dart';

  final appStateProvider = StateProvider<AppLifecycleState>( (ref) => AppLifecycleState.resumed );