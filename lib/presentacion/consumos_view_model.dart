// lib/presentacion/consumos_view_model.dart
// Etapa 3 — ViewModel con ChangeNotifier (cuerpos pendientes).

import 'package:flutter/foundation.dart';

import 'package:ecotrack_meta/datos/consumo_repository.dart';
import 'package:ecotrack_meta/dominio/consumo.dart';
import 'package:ecotrack_meta/dominio/meta.dart';

class ConsumosViewModel extends ChangeNotifier {
  ConsumosViewModel(ConsumoRepository repositorio) : _repositorio = repositorio;

  // ignore: unused_field
  final ConsumoRepository _repositorio;

  List<Consumo> consumos = [];      // empieza vacía
  String? error;                    // empieza en null
  bool guardando = false;           // empieza en false
  double meta = metaInicial;        // empieza en metaInicial

  double get total => throw UnimplementedError('Etapa 3: total');
  double get avance => throw UnimplementedError('Etapa 3: avance');
  bool get metaSuperada => throw UnimplementedError('Etapa 3: metaSuperada');

  Future<void> cargar() {
    throw UnimplementedError('Etapa 3: cargar');
  }

  // true si se guardó
  Future<bool> guardar(String laboratorio, String litrosTexto) {
    throw UnimplementedError('Etapa 3: guardar');
  }

  void subirMeta() {
    throw UnimplementedError('Etapa 3: subirMeta');
  }

  void bajarMeta() {
    throw UnimplementedError('Etapa 3: bajarMeta');
  }
}
