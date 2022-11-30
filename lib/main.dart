import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/poke_list_item.dart';
import 'package:pokemon/providers/pokemon_provider.dart';
import 'package:pokemon/providers/theme_mode_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.state); // 非推奨だが対処が分からなかった①
    return MaterialApp(
      title: 'Pokemon Flutter',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode.state,
      home: TopPage(),
    );
  }
}

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.state); // 非推奨だが対処が分からなかった①
    List<Pokemon> pokes = ref.watch(pokemonsProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton<ThemeMode>(
              icon: const Icon(
                Icons.settings_brightness,
              ),
              onSelected: (ThemeMode selectedThemeMode) =>
                  themeMode.state = selectedThemeMode,
              itemBuilder: (context) => <PopupMenuEntry<ThemeMode>>[
                const PopupMenuItem(
                  value: ThemeMode.system,
                  child: Text('システム設定に従う'),
                ),
                const PopupMenuItem(
                  value: ThemeMode.light,
                  child: Text('ライトモード'),
                ),
                const PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Text('ダークモード'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return PokeListItem(
            poke: pokes.byId(index + 1),
          );
        },
      ),
    );
  }
}
