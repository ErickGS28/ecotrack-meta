# Gestión de estado — EcoTrack Meta

**Equipo:** Erick (piloto/copiloto: completar nombres de la pareja)
**Fecha:** 2026-10-26

## Tipos de estado en nuestro código

| Dato | Tipo (efímero, compartido, derivado, persistido) | Dónde vive |
|---|---|---|
| Pestaña activa | Efímero: solo le importa a `PantallasEcoTrack`, nadie más la lee. | Campo `_indice` en `_PantallasEcoTrackState` (`lib/presentacion/vistas.dart`), cambiado con `setState`. |
| Texto del campo de litros | Efímero: es lo que se está escribiendo, aún no es un dato de la app. | `TextEditingController _litros` (y `_laboratorio`) en `_FormularioRegistroState` (`lib/presentacion/vistas.dart`). |
| consumos y meta | Compartido: Registro, Historial y Meta los leen o los cambian. | Campos `consumos` y `meta` de `ConsumosViewModel` (`lib/presentacion/consumos_view_model.dart`). |
| total y metaSuperada | Derivado: se calculan a partir de `consumos` y `meta`, no se guardan. | Getters `total` y `metaSuperada` de `ConsumosViewModel` (el punto 3 de `verificar_estado.sh` comprueba que `total` sea getter). |
| Lo que regresa todos() | Persistido: es la fuente de verdad; el ViewModel solo guarda una copia que relee tras cada `guardar`. | Lista privada `_consumos` de `MemoriaConsumoRepository` (`lib/datos/memoria_consumo_repository.dart`), expuesta como `List.unmodifiable`. |

## Criterios

| Criterio | A · ChangeNotifier puro | B · provider |
|---|---|---|
| Dato compartido | Un solo `ConsumosViewModel`, creado en `_AppChangeNotifierState.initState` y pasado a `RegistroCN`, `HistorialCN` y `MetaCN`. Lo comprueba la prueba "Dato compartido" de `etapa4_change_notifier_test.dart`. | Un solo `ConsumosViewModel`, creado por el `ChangeNotifierProvider` de `AppProvider`; los tres adaptadores lo piden al árbol. Lo comprueba la prueba "Dato compartido" de `etapa5_provider_test.dart`. |
| Capas | `vistas.dart` no importa el ViewModel, `provider` ni `datos/`; `a_change_notifier.dart` es la única pieza que une vista y ViewModel (`verificar_estado.sh`, puntos 4 y 5 en OK). | Igual: `vistas.dart` y `consumos_view_model.dart` no cambiaron; solo `b_provider.dart` une vista y ViewModel (puntos 4 y 6 en OK). |
| Encaje con el diagrama | Vista tonta → adaptador `*CN` (con `ListenableBuilder`) → `ConsumosViewModel` → dominio y `ConsumoRepository`. | Vista tonta → adaptador `*Provider` (con `context.watch`/`context.read`) → `ConsumosViewModel` → dominio y `ConsumoRepository`. Solo cambia el adaptador. |
| Constructores que reciben vm | 3: `RegistroCN`, `HistorialCN` y `MetaCN` (`required this.vm`). | 0: `RegistroProvider`, `HistorialProvider` y `MetaProvider` solo tienen `super.key` y son `const`. |
| Quién libera el ViewModel | Nosotros: `_AppChangeNotifierState.dispose()` llama a `_vm.dispose()`; quien lo crea lo libera. | El `ChangeNotifierProvider`: al salir del árbol llama a `dispose()` solo; no hay `dispose()` escrito en `b_provider.dart`. |
| Costo de adoptarla ahora | Cero dependencias nuevas, pero hay que pasar `vm` a mano por cada constructor (3 hoy; más si Meta tuviera una subpantalla). | Una dependencia (`provider: ^6.1.5+1` en `pubspec.yaml`) y a cambio ningún constructor recibe `vm`. |
| Sustitución de la fuente de datos | `RepositorioEspia` entra por `AppChangeNotifier(repositorio: ...)` y las pantallas no cambian (prueba "Sustitución" de la etapa 4). | `RepositorioEspia` entra por `AppProvider(repositorio: ...)` y las pantallas no cambian (prueba "Sustitución" de la etapa 5); solo `main*.dart` elige la fuente. |

## Elección

Elegimos: B · provider.
Se mantiene esta pieza del diagrama: `ConsumosViewModel` (junto con las reglas de `dominio/`): pasó de A a B sin cambiar una sola línea.
Esta pieza es la que podría sustituirse después: `MemoriaConsumoRepository`, porque `ConsumosViewModel` solo conoce el contrato `ConsumoRepository` y las pantallas no se enteran del cambio.
