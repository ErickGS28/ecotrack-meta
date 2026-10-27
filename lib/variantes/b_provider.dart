// lib/variantes/b_provider.dart
// Etapa 5 — Cableado B: provider sobre el MISMO ViewModel (cuerpos pendientes).

import 'package:flutter/material.dart';

import 'package:ecotrack_meta/datos/consumo_repository.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.repositorio});

  final ConsumoRepository repositorio;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 5: AppProvider');
  }
}

class RegistroProvider extends StatelessWidget {
  const RegistroProvider({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 5: RegistroProvider');
  }
}

class HistorialProvider extends StatelessWidget {
  const HistorialProvider({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 5: HistorialProvider');
  }
}

class MetaProvider extends StatelessWidget {
  const MetaProvider({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 5: MetaProvider');
  }
}
