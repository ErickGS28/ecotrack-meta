// lib/variantes/b_provider.dart
// Etapa 5 — Cableado B: provider sobre el MISMO ViewModel.
// watch para mostrar (en build), read para actuar (en callbacks).

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecotrack_meta/datos/consumo_repository.dart';
import 'package:ecotrack_meta/presentacion/consumos_view_model.dart';
import 'package:ecotrack_meta/presentacion/vistas.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.repositorio});

  final ConsumoRepository repositorio;

  @override
  Widget build(BuildContext context) {
    // El provider crea, carga y (al salir del árbol) libera el ViewModel.
    return ChangeNotifierProvider<ConsumosViewModel>(
      create: (_) => ConsumosViewModel(repositorio)..cargar(),
      child: const MaterialApp(
        home: PantallasEcoTrack(
          titulo: 'B · provider',
          registro: RegistroProvider(),
          historial: HistorialProvider(),
          meta: MetaProvider(),
        ),
      ),
    );
  }
}

// Adaptadores: no reciben nada por constructor, piden el ViewModel al árbol.
class RegistroProvider extends StatelessWidget {
  const RegistroProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConsumosViewModel>();
    return FormularioRegistro(
      alGuardar: (laboratorio, litros) =>
          context.read<ConsumosViewModel>().guardar(laboratorio, litros),
      error: vm.error,
      guardando: vm.guardando,
    );
  }
}

class HistorialProvider extends StatelessWidget {
  const HistorialProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConsumosViewModel>();
    return ListaHistorial(consumos: vm.consumos, total: vm.total);
  }
}

class MetaProvider extends StatelessWidget {
  const MetaProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConsumosViewModel>();
    return PanelMeta(
      usado: vm.total,
      meta: vm.meta,
      avance: vm.avance,
      superada: vm.metaSuperada,
      alSubir: () => context.read<ConsumosViewModel>().subirMeta(),
      alBajar: () => context.read<ConsumosViewModel>().bajarMeta(),
    );
  }
}
