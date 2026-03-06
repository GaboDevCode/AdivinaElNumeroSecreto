#     Adivina el numero secreto

Aplicación desarrollada en Flutter como parte de una prueba técnica.
El objetivo del juego es adivinar un número secreto dentro de un rango definido por el nivel de dificultad seleccionado.

## Descripción del Juego

El sistema genera un número aleatorio dentro de un rango definido por la dificultad.
El jugador debe intentar adivinar el número antes de quedarse sin intentos.

Después de cada intento, el juego indica si el número secreto es mayor o menor que el número ingresado.

Si el jugador adivina el número antes de agotar los intentos, gana la partida.
Si se terminan los intentos, el jugador pierde.

## Niveles de Dificultad

| Dificultad | Rango    | Intentos |
| ---------- | -------- | -------- |
| Fácil      | 1 - 10   | 5        |
| Medio      | 1 - 20   | 8        |
| Avanzado   | 1 - 100  | 15       |
| Extremo    | 1 - 1000 | 25       |

## Arquitectura

El proyecto utiliza el patrón MVVM (Model - View - ViewModel) para separar responsabilidades entre la interfaz de usuario y la lógica de negocio.

Estructura conceptual:

UI (Widgets)
↓
ViewModel (GameViewModel)
↓
Models (GameDifficulty, GameResult)

Esto permite mantener la lógica del juego independiente de la interfaz, facilitando el mantenimiento y la creación de pruebas unitarias.

## Gestión de Estado

La gestión de estado se realiza utilizando Provider junto con ChangeNotifier.

El GameViewModel es responsable de:

* Generar el número secreto
* Validar los intentos del jugador
* Controlar el número de intentos restantes
* Determinar el estado del juego (ganado o perdido)
* Mantener el historial de partidas

## Estructura del Proyecto

```
lib
 ├── models
 │     ├── game_difficulty.dart
 │     └── game_result.dart
 │
 ├── viewmodels
 │     └── game_viewmodel.dart
 │
 ├── views
 │     └── game_view.dart
 │
 └── widgets
```

## Pruebas Unitarias

Se implementaron pruebas unitarias para validar la lógica principal del juego.

Las pruebas cubren:

* Inicialización del juego
* Generación del número secreto dentro del rango permitido
* Validación de entradas inválidas
* Validación de números fuera de rango
* Condición de victoria
* Registro de intentos menores y mayores
* Condición de derrota al agotar intentos
* Reinicio del juego al cambiar la dificultad

Para ejecutar las pruebas:

```
flutter test
```

## Cómo ejecutar el proyecto

1. Clonar el repositorio

```
git clone <repository-url>
```

2. Instalar dependencias

```
flutter pub get
```

3. Ejecutar la aplicación

```
flutter run
```

## Tecnologías utilizadas

* Flutter
* Dart
* Provider
* Flutter Test

## Decisiones Técnicas

Durante el desarrollo se tomaron las siguientes decisiones técnicas:

Separación de responsabilidades
Se utilizó el patrón MVVM para mantener la lógica de negocio separada de la interfaz de usuario. Esto permite mejorar la mantenibilidad del código y facilita la creación de pruebas unitarias.

Gestión de estado simple
Se eligió Provider con ChangeNotifier por ser una solución ligera y suficiente para la complejidad de la aplicación.

Encapsulación del estado del juego
La lógica principal del juego se concentra en el GameViewModel, evitando que los widgets manejen lógica de negocio.

Uso de modelos para el dominio
Las entidades GameDifficulty y GameResult representan los conceptos principales del dominio del juego, facilitando la organización del código.

Cobertura mediante pruebas unitarias
Se implementaron pruebas unitarias para validar el comportamiento del GameViewModel y asegurar que la lógica del juego funcione correctamente.

## Posibles mejoras

* Persistencia del historial de partidas utilizando SQLite o Hive
* Mejora del feedback visual en la interfaz
* Estadísticas de partidas jugadas
* Animaciones en la interfaz

## Autor

Prueba técnica desarrollada por Eduardo Gabriel Bocanegra Toledo
