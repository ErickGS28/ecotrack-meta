// lib/dominio/consumo.dart
// Etapa 1 — Dominio. Firmas del contrato (cuerpos pendientes).

const laboratoriosUtez = ['Lab Química', 'Lab Redes', 'Lab Física'];

class Consumo {
  const Consumo({required this.laboratorio, required this.litros});
  final String laboratorio;
  final double litros;
}

// mensaje de error o null
String? validarLitros(double? litros) {
  throw UnimplementedError('Etapa 1: implementar validarLitros');
}
