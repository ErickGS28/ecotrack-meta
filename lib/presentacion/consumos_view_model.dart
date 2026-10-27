// lib/presentacion/consumos_view_model.dart
// Etapa 3 — ViewModel con ChangeNotifier. Único dueño del estado compartido.

// foundation.dart (no material.dart): el ViewModel avisa, no dibuja.
import 'package:flutter/foundation.dart';

import 'package:ecotrack_meta/datos/consumo_repository.dart';
import 'package:ecotrack_meta/dominio/consumo.dart';
import 'package:ecotrack_meta/dominio/meta.dart';

class ConsumosViewModel extends ChangeNotifier {
  // Recibe el contrato: nunca sabe si es memoria, disco o nube.
  ConsumosViewModel(this._repositorio);

  final ConsumoRepository _repositorio;

  // Estado compartido.
  List<Consumo> consumos = []; // empieza vacía
  String? error; // empieza en null
  bool guardando = false; // empieza en false
  double meta = metaInicial; // empieza en metaInicial

  // Estado derivado: se calcula, no se guarda.
  double get total => consumos.fold(0.0, (suma, c) => suma + c.litros);
  double get avance => avanceDeMeta(total: total, meta: meta);
  bool get metaSuperada => total > meta;

  // Lee del repositorio (fuente de verdad) y avisa.
  Future<void> cargar() async {
    consumos = await _repositorio.todos();
    notifyListeners();
  }

  // true si se guardó.
  Future<bool> guardar(String laboratorio, String litrosTexto) async {
    // Acepta coma decimal y espacios: " 12,5 " -> 12.5
    final litros = double.tryParse(litrosTexto.trim().replaceAll(',', '.'));

    // La regla vive en el dominio.
    final mensaje = validarLitros(litros);
    if (mensaje != null) {
      error = mensaje;
      notifyListeners();
      return false;
    }

    // Válido: marca guardando, limpia el error y avisa.
    guardando = true;
    error = null;
    notifyListeners();

    // Guarda y vuelve a leer la lista completa del repositorio.
    await _repositorio.guardar(
      Consumo(laboratorio: laboratorio, litros: litros!),
    );
    consumos = await _repositorio.todos();

    // Desmarca guardando y avisa.
    guardando = false;
    notifyListeners();
    return true;
  }

  // El mínimo lo decide ajustarMeta, no el ViewModel.
  void subirMeta() {
    meta = ajustarMeta(meta, pasoMeta);
    notifyListeners();
  }

  void bajarMeta() {
    meta = ajustarMeta(meta, -pasoMeta);
    notifyListeners();
  }
}
