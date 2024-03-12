import 'package:flutter/material.dart'; // Importa el paquete de Flutter para widgets de Material Design.
import 'dart:math'
    as math; // Importa el paquete de matemáticas para operaciones matemáticas.

class Responsive {
  // Define la clase Responsive.
  late double _width,
      _height,
      _diagonal; // Declara variables para almacenar el ancho, alto y diagonal de la pantalla.
  late bool
      _isTablet; // Declara una variable para determinar si el dispositivo es una tablet o no.

  // Métodos getter para acceder a las propiedades privadas de la clase.
  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;

  // Método estático para obtener una instancia de la clase Responsive a partir de un contexto de Flutter.
  static Responsive of(BuildContext context) => Responsive(context);

  // Constructor de la clase Responsive que recibe un contexto de Flutter.
  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context)
        .size; // Obtiene el tamaño de la pantalla del contexto proporcionado.
    _width = size.width; // Asigna el ancho de la pantalla a la variable _width.
    _height =
        size.height; // Asigna el alto de la pantalla a la variable _height.

    // Calcula la diagonal de la pantalla utilizando el teorema de Pitágoras.
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));

    // Determina si el dispositivo es una tablet basándose en el tamaño de su lado más corto.
    _isTablet = size.shortestSide >= 600;
  }

  // Método para obtener un porcentaje del ancho de la pantalla.
  double wp(double percent) => (_width * percent) / 100;

  // Método para obtener un porcentaje del alto de la pantalla.
  double hp(double percent) => (_height * percent) / 100;

  // Método para obtener un porcentaje de la diagonal de la pantalla.
  double dp(double percent) => (_diagonal * percent) / 100;
}
