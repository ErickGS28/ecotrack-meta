// lib/presentacion/vistas.dart — widgets tontos
// Etapa 4 — Vistas (cuerpos pendientes).

import 'package:flutter/material.dart';

class FormularioRegistro extends StatefulWidget {
  const FormularioRegistro({
    super.key,
    required this.alGuardar, // Future<bool> Function(String laboratorio, String litros)
    required this.error, // String?
    required this.guardando, // bool
  });

  final Future<bool> Function(String laboratorio, String litros) alGuardar;
  final String? error;
  final bool guardando;

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 4: FormularioRegistro');
  }
}

class ListaHistorial extends StatelessWidget {
  const ListaHistorial({super.key, required this.consumos, required this.total});

  final List<Object> consumos;
  final double total;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 4: ListaHistorial');
  }
}

class PanelMeta extends StatelessWidget {
  const PanelMeta({
    super.key,
    required this.usado, // double
    required this.meta, // double
    required this.avance, // double
    required this.superada, // bool
    required this.alSubir, // VoidCallback
    required this.alBajar, // VoidCallback
  });

  final double usado;
  final double meta;
  final double avance;
  final bool superada;
  final VoidCallback alSubir;
  final VoidCallback alBajar;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 4: PanelMeta');
  }
}

class PantallasEcoTrack extends StatefulWidget {
  const PantallasEcoTrack({
    super.key,
    required this.titulo,
    required this.registro,
    required this.historial,
    required this.meta,
  });

  final String titulo;
  final Widget registro;
  final Widget historial;
  final Widget meta;

  @override
  State<PantallasEcoTrack> createState() => _PantallasEcoTrackState();
}

class _PantallasEcoTrackState extends State<PantallasEcoTrack> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Etapa 4: PantallasEcoTrack');
  }
}
