

import 'dart:math';

// Nivel de dificultad con su rango de números e intentos permitidos
class Nivel {
  final String nombre;
  final int numeroMaximo;
  final int intentosMaximos;

  const Nivel({
    required this.nombre,
    required this.numeroMaximo,
    required this.intentosMaximos,
  });
}

class EntradaHistorial {
  final int numero;
  final bool correcto;

  const EntradaHistorial({required this.numero, required this.correcto});
}


class Juego {
  // Niveles de dificultad con numero de intentos
  static const List<Nivel> niveles = [
    Nivel(nombre: 'Fácil',    numeroMaximo: 10,   intentosMaximos: 5),
    Nivel(nombre: 'Medio',    numeroMaximo: 20,   intentosMaximos: 8),
    Nivel(nombre: 'Avanzado', numeroMaximo: 100,  intentosMaximos: 15),
    Nivel(nombre: 'Extremo',  numeroMaximo: 1000, intentosMaximos: 25),
  ];

  Nivel nivelActual = niveles[0];
  late int numeroSecreto;
  int intentosRestantes = 0;
  bool terminado = false;
  bool gano = false;

  List<int> mayoresQue = [];
  List<int> menoresQue = [];
  List<EntradaHistorial> historial = [];

  Juego() {
    iniciar();
  }

  void iniciar() {
    numeroSecreto = Random().nextInt(nivelActual.numeroMaximo) + 1;
    intentosRestantes = nivelActual.intentosMaximos;
    mayoresQue = [];
    menoresQue = [];
    terminado = false;
    gano = false;
  }

  void cambiarNivel(Nivel nivel) {
    nivelActual = nivel;
    iniciar();
  }

  String? adivinar(String entrada) {
    final numero = int.tryParse(entrada);

    if (numero == null) return 'Ingresa un número válido. \nNo puedes poner letras ni simbolos.';
    if (numero < 1 || numero > nivelActual.numeroMaximo) {
      return 'El número debe estar entre 1 y ${nivelActual.numeroMaximo}';
    }
    if (terminado) return 'El juego terminó, reinicia';

    intentosRestantes--;

    if (numero == numeroSecreto) {
      gano = true;
      terminado = true;
      historial.add(EntradaHistorial(numero: numero, correcto: true));
    } else {
      if (numero > numeroSecreto) {
        mayoresQue.add(numero);
      } else {
        menoresQue.add(numero);
      }

      if (intentosRestantes == 0) {
        terminado = true;
        historial.add(EntradaHistorial(numero: numero, correcto: false));
      }
    }

    return null;
  }

  void reiniciar() => iniciar();
}