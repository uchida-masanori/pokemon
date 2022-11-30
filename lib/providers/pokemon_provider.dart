import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/api/pokeapi.dart';

class Pokemon {
  const Pokemon(
      {required this.id,
      required this.name,
      required this.types,
      required this.imageUrl});

  // イミュータブルなクラスのプロパティはすべて `final` にする必要があります。
  final int id;
  final String name;
  final List<String> types;
  final String imageUrl;

  // Pokemon はイミュータブルであり、内容を直接変更できないためコピーを作る必要があります。
  // これはオブジェクトの各プロパティの内容をコピーして新たな Pokemon を返すメソッドです。
  Pokemon copyWith(
      {int? id, String? name, List<String>? types, String? imageUrl}) {
    return Pokemon(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      types: types ?? this.types,
    );
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> typesToList(dynamic types) {
      List<String> ret = [];
      for (int i = 0; i < types.length; i++) {
        ret.add(types[i]['type']['name']);
      }
      return ret;
    }

    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: typesToList(json['types']),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}

class PokemonsNotifier extends StateNotifier<List<Pokemon>> {
  PokemonsNotifier() : super([]);
  // ID, Pokemon
  final Map<int, Pokemon?> _pokeMap = {};

  Map<int, Pokemon?> get pokes => _pokeMap;

  void addPoke(Pokemon poke) {
    _pokeMap[poke.id] = poke;
    state = [...state, poke];
  }

  void fetchPoke(int id) async {
    _pokeMap[id] = null;
    addPoke(await fetchPokemon(id));
  }

  Pokemon? byId(int id) {
    if (!_pokeMap.containsKey(id)) {
      fetchPoke(id);
    }
    return _pokeMap[id];
  }
}

final pokemonsProvider =
    StateNotifierProvider<PokemonsNotifier, List<Pokemon>>(((ref) {
  return PokemonsNotifier();
}));
