import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class Favorite {
  const Favorite(
      {required this.id,
      required this.name,
      required this.isFavorite,
      required this.completed});

  // イミュータブルなクラスのプロパティはすべて `final` にする必要があります。
  final int id;
  final String name;
  final bool isFavorite;
  final bool completed;

  Favorite copyWith(
      {int? id, String? name, bool? isFavorite, required bool completed}) {
    return Favorite(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      completed: isFavorite ?? this.isFavorite,
    );
  }
}

class FavoritesNotifier extends StateNotifier<List<Favorite>> {
  // リストを空のリストとして初期化
  FavoritesNotifier() : super([]);

  void addTodo(Favorite fav) {
    state = [...state, fav];
  }

  void removeTodo(String favId) {
    state = [
      for (final fav in state)
        if (fav.id != favId) fav,
    ];
  }

  // 完了ステータスの変更
  void toggle(String favId) {
    state = [
      for (final fav in state)
        if (fav.id == favId) fav.copyWith(completed: !fav.completed) else fav,
    ];
  }
}

final FavoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Favorite>>((ref) {
  return FavoritesNotifier();
});
