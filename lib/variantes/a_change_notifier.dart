// lib/variantes/a_change_notifier.dart
// Etapa 4 — Cableado A: ChangeNotifier puro, por constructor (cuerpos pendientes).

import 'package:flutter/material.dart';

import 'package:ecotrack_meta/datos/consumo_repository.dart';
import 'package:ecotrack_meta/presentacion/consumos_view_model.dart';

class AppChangeNotifier extends StatefulWidget {
  const AppChangeNotifier({super.key, required this.repositorio});

  final ConsumoRepository repositorio;

  @override
  State<AppChangeNotifier> createState() => _AppChangeNotifierState();
}

class _AppChangeNotifierState extends State<AppChangeNotifier> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 4: AppChangeNotifier');
  }
}

class RegistroCN extends StatelessWidget {
  const RegistroCN({super.key, required this.vm});

  final ConsumosViewModel vm;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 4: RegistroCN');
  }
}

class HistorialCN extends StatelessWidget {
  const HistorialCN({super.key, required this.vm});

  final ConsumosViewModel vm;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 4: HistorialCN');
  }
}

class MetaCN extends StatelessWidget {
  const MetaCN({super.key, required this.vm});

  final ConsumosViewModel vm;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 4: MetaCN');
  }
}
