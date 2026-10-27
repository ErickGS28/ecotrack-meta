// lib/dominio/consumo.dart
// Etapa 1 — Dominio. Firmas del contrato (cuerpos pendientes).

const laboratoriosUtez = ['Lab Química', 'Lab Redes', 'Lab Física'];

class Consumo {
  const Consumo({required this.laboratorio, required this.litros});
  final String laboratorio;
  final double litros;
}

// Tope máximo de litros por registro.
const _topeLitros = 10000;

// mensaje de error o null
String? validarLitros(double? litros) {
  // 1) No es número.
  if (litros == null) return 'Escribe los litros con número';
  // 2) Cero o negativo.
  if (litros <= 0) return 'Los litros deben ser mayores que cero';
  // 3) Más del tope.
  if (litros > _topeLitros) return 'Los litros superan el tope de $_topeLitros';
  // Todo bien.
  return null;
}
