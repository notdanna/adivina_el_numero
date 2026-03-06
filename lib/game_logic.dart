

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