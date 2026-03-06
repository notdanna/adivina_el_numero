
import 'package:flutter/material.dart';
import 'game_logic.dart';

class PantallaJuego extends StatefulWidget {
  const PantallaJuego({super.key});

  @override
  State<PantallaJuego> createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego> {
  final Juego juego = Juego();
  final TextEditingController campo = TextEditingController();
  String? error;

  void adivinar() {
    setState(() {
      error = juego.adivinar(campo.text.trim());
      campo.clear();
    });
  }

  void cambiarNivel(Nivel nivel) {
    setState(() {
      juego.cambiarNivel(nivel);
      error = null;
      campo.clear();
    });
  }

  void reiniciar() {
    setState(() {
      juego.reiniciar();
      error = null;
      campo.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina el número'),
        actions: [
          PopupMenuButton<Nivel>(
            icon: const Icon(Icons.menu),
            onSelected: cambiarNivel,
            itemBuilder: (_) => Juego.niveles
                .map((n) => PopupMenuItem(value: n, child: Text(n.nombre)))
                .toList(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FractionallySizedBox(
          heightFactor: 0.6,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: campo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Números',
                        errorText: error,
                        border: const OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => adivinar(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      const Text('Intentos'),
                      Text(
                        '${juego.intentosRestantes}',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: Row(
                  children: [
                    _columna('Mayor que', juego.mayoresQue, Colors.white),
                    const SizedBox(width: 8),
                    _columna('Menor que', juego.menoresQue, Colors.white),
                    const SizedBox(width: 8),
                    _columnaHistorial(),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Text(juego.nivelActual.nombre),
              Slider(
                value: Juego.niveles.indexOf(juego.nivelActual).toDouble(),
                min: 0,
                max: (Juego.niveles.length - 1).toDouble(),
                divisions: Juego.niveles.length - 1,
                onChanged: (v) => cambiarNivel(Juego.niveles[v.toInt()]),
              ),

              if (juego.terminado) ...[
                const SizedBox(height: 8),
                Text(
                  juego.gano
                      ? '¡Ganaste! :) \nEl número era ${juego.numeroSecreto}'
                      : 'Perdiste :( \nEl número er ${juego.numeroSecreto}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: juego.gano ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                FilledButton(onPressed: reiniciar, child: const Text('Jugar de nuevo')),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _columna(String titulo, List<int> numeros, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: numeros
                    .map((n) => Text('$n',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: color, fontSize: 16)))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _columnaHistorial() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text('Historial', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: juego.historial
                    .map((e) => Text(
                  '${e.numero}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: e.correcto ? Colors.green : Colors.red,
                  ),
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}