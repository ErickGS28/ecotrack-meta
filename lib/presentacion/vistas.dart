// lib/presentacion/vistas.dart — widgets tontos
// Etapa 4a — Reciben datos y callbacks. No saben qué gestor de estado hay arriba.

import 'package:flutter/material.dart';

import 'package:ecotrack_meta/dominio/consumo.dart';

// ---------------------------------------------------------------------------
// Registro
// ---------------------------------------------------------------------------
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
  // Estado efímero: el laboratorio elegido y el texto del campo viven aquí.
  String _laboratorio = laboratoriosUtez.first;
  final TextEditingController _litros = TextEditingController();

  @override
  void dispose() {
    _litros.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final ok = await widget.alGuardar(_laboratorio, _litros.text);
    // Después de un await, revisar mounted antes de usar el context.
    if (!mounted) return;
    if (ok) {
      _litros.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consumo guardado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _laboratorio,
            decoration: const InputDecoration(labelText: 'Laboratorio'),
            items: [
              for (final lab in laboratoriosUtez)
                DropdownMenuItem(value: lab, child: Text(lab)),
            ],
            onChanged: (valor) {
              if (valor != null) setState(() => _laboratorio = valor);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            key: const Key('litros'),
            controller: _litros,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Litros',
              errorText: widget.error,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            // Desactivado mientras se guarda.
            onPressed: widget.guardando ? null : _guardar,
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Historial
// ---------------------------------------------------------------------------
class ListaHistorial extends StatelessWidget {
  const ListaHistorial({
    super.key,
    required this.consumos,
    required this.total,
  });

  final List<Consumo> consumos;
  final double total;

  @override
  Widget build(BuildContext context) {
    if (consumos.isEmpty) {
      return const Center(child: Text('Sin consumos'));
    }
    return ListView(
      children: [
        ListTile(
          title: Text(
            'Total: ${total.toStringAsFixed(1)} L',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Divider(height: 1),
        for (final c in consumos)
          ListTile(
            leading: const Icon(Icons.water_drop_outlined),
            title: Text(c.laboratorio),
            trailing: Text('${c.litros.toStringAsFixed(1)} L'),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Meta
// ---------------------------------------------------------------------------
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
    final colores = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Usado: ${usado.toStringAsFixed(1)} de ${meta.toStringAsFixed(1)} L',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: avance, minHeight: 10),
          const SizedBox(height: 12),
          Text(
            superada ? 'Te pasaste de la meta' : 'Dentro de la meta',
            style: TextStyle(
              color: superada ? colores.error : colores.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                key: const Key('bajarMeta'),
                tooltip: 'Bajar meta',
                onPressed: alBajar,
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 24),
              IconButton.filled(
                key: const Key('subirMeta'),
                tooltip: 'Subir meta',
                onPressed: alSubir,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Contenedor con barra inferior
// ---------------------------------------------------------------------------
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
  // Estado efímero: la pestaña activa.
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      // IndexedStack mantiene montadas las tres pestañas y solo enseña una.
      body: IndexedStack(
        index: _indice,
        children: [widget.registro, widget.historial, widget.meta],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (i) => setState(() => _indice = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.edit_note), label: 'Registro'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'Historial'),
          NavigationDestination(icon: Icon(Icons.flag_outlined), label: 'Meta'),
        ],
      ),
    );
  }
}
