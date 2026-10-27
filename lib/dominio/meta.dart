// lib/dominio/meta.dart
// Etapa 1 — Dominio. Firmas del contrato (cuerpos pendientes).

const metaInicial = 100.0;
const pasoMeta = 10.0;
const metaMinima = 10.0;

// Suma el cambio a la meta actual, sin bajar nunca de metaMinima.
double ajustarMeta(double actual, double cambio) {
  final nueva = actual + cambio;
  return nueva < metaMinima ? metaMinima : nueva;
}

// Fracción de la meta ya usada, entre 0 y 1 (1 si se rebasó).
double avanceDeMeta({required double total, required double meta}) {
  // Evita dividir entre cero.
  if (meta <= 0) return 0;
  final fraccion = total / meta;
  if (fraccion < 0) return 0;
  if (fraccion > 1) return 1;
  return fraccion;
}
