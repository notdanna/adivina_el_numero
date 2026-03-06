# Adivina el número

Ejercicio en Flutter como becario. El juego consiste en adivinar un número secreto dentro de un rango según el nivel de dificultad elegido.

## Cómo jugar

1. Ingresa un número en el campo de texto y presiona Enter
2. El juego te indica si tu número fue mayor o menor que el secreto
3. Tienes un número limitado de intentos según el nivel
4. Si aciertas antes de quedarte sin intentos, ¡ganas!

## Niveles de dificultad

| Nivel    | Rango       | Intentos |
|----------|-------------|----------|
| Fácil    | 1 al 10     | 5        |
| Medio    | 1 al 20     | 8        |
| Avanzado | 1 al 100    | 15       |
| Extremo  | 1 al 1000   | 25       |

Puedes cambiar el nivel desde el menú (ícono ☰) o con el slider en la parte inferior. Al cambiar el nivel el juego se reinicia automáticamente.

## Columnas

- **Mayor que**: números que ingresaste que son mayores que el secreto
- **Menor que**: números que ingresaste que son menores que el secreto
- **Historial**: todos los intentos finales de partidas anteriores (verde = ganaste, rojo = perdiste)

## Estructura del proyecto
```
lib/
├── main.dart         # Llamada principal y configuración del tema
├── game_logic.dart   # Lógica del juego: niveles, validación, historial
└── game_screen.dart  # Pantalla principal y UI
```

## Tecnologías

- Flutter 3.x
- Dart
- Material Design 3