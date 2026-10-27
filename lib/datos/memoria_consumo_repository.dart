// lib/datos/memoria_consumo_repository.dart
// Etapa 2 — Datos. Implementación en memoria del contrato.

import 'package:ecotrack_meta/datos/consumo_repository.dart';
import 'package:ecotrack_meta/dominio/consumo.dart';

class MemoriaConsumoRepository implements ConsumoRepository {
  // Lista privada: nadie fuera de esta clase la puede tocar.
  final List<Consumo> _consumos = [];

  @override
  // Async aunque responda al instante: una fuente real (red, disco) tardaría.
  Future<void> guardar(Consumo consumo) async {
    _consumos.add(consumo);
  }

  @override
  // Copia no modificable: agregar o quitar desde fuera lanza UnsupportedError.
  Future<List<Consumo>> todos() async => List.unmodifiable(_consumos);
}
