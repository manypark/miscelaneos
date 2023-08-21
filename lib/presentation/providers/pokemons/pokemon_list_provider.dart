import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonsIdsProvider = StateProvider<List<int>>((ref) {
  return List.generate( 30 , (index) => index + 1);
});