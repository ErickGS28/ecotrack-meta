// lib/datos/memoria_consumo_repository.dart
// Etapa 2 — Datos. Implementación en memoria (cuerpos pendientes).

import 'package:ecotrack_meta/datos/consumo_repository.dart';
import 'package:ecotrack_meta/dominio/consumo.dart';

class MemoriaConsumoRepository implements ConsumoRepository {
  @override
  Future<void> guardar(Consumo consumo) {
    throw UnimplementedError('Etapa 2: implementar guardar');
  }

  @override
  Future<List<Consumo>> todos() {
    throw UnimplementedError('Etapa 2: implementar todos');
  }
}
