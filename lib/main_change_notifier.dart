// lib/main_change_notifier.dart
// Etapa 4c — Arranca la variante A con la fuente de datos en memoria.
//   flutter run -t lib/main_change_notifier.dart

import 'package:flutter/material.dart';

import 'package:ecotrack_meta/datos/memoria_consumo_repository.dart';
import 'package:ecotrack_meta/variantes/a_change_notifier.dart';

void main() {
  runApp(AppChangeNotifier(repositorio: MemoriaConsumoRepository()));
}
