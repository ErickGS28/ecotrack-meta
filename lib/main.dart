// lib/main.dart
// Etapa 5 — Arranca la variante B (provider) con la fuente de datos en memoria.
//   flutter run

import 'package:flutter/material.dart';

import 'package:ecotrack_meta/datos/memoria_consumo_repository.dart';
import 'package:ecotrack_meta/variantes/b_provider.dart';

void main() {
  runApp(AppProvider(repositorio: MemoriaConsumoRepository()));
}
