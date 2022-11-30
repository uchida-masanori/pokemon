// デフォルトはシステム設定に従う(ThemeMode.system)ようにしておくといいかも
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
