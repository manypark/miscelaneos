import 'package:isar/isar.dart';

part 'pokemon.g.dart';

@collection
class Pokemon {

  Id iisarId = Isar.autoIncrement;

  final int id;
  final String name;
  final String spritefront;

  Pokemon({
    required this.id, 
    required this.name, 
    required this.spritefront
  });
  
}
