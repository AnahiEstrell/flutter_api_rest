import 'package:flutter/material.dart';

// Widget para entrada de texto personalizada
class InputText extends StatelessWidget {
  final String label; // Etiqueta del campo de entrada
  final TextInputType keyBoardType; // Tipo de teclado
  final bool obscureText, borderEnabled; // Bandera para texto oculto y activación de borde
  final double fontSize; // Tamaño de fuente
  final void Function(String text) onChanged; // Función llamada cuando cambia el texto
  final String? Function(String? text)? validator; // Validador de entrada opcional
  const InputText({
    super.key,
    this.label = '', // Valor predeterminado para la etiqueta
    this.keyBoardType = TextInputType.text, // Valor predeterminado para el tipo de teclado
    this.obscureText = false, // Valor predeterminado para el texto oculto
    this.borderEnabled = true, // Valor predeterminado para la activación del borde
    this.fontSize = 15, // Tamaño de fuente predeterminado
    required this.onChanged, // Función de cambio de texto requerida
    this.validator, // Validador de entrada opcional
  });

  // Método para construir la interfaz de usuario del campo de entrada de texto
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: fontSize), // Estilo de texto con el tamaño de fuente especificado
      keyboardType: keyBoardType, // Tipo de teclado especificado
      obscureText: obscureText, // Si el texto debe ocultarse o no
      onChanged: onChanged, // Función llamada cuando cambia el texto
      validator: validator, // Validador de entrada opcional
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5), // Relleno del contenido
        enabledBorder: borderEnabled // Borde habilitado si está activado
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12)) // Borde subrayado con color predeterminado
            : InputBorder.none, // No se muestra ningún borde si no está activado
        labelText: label, // Etiqueta del campo de entrada
        labelStyle: const TextStyle(
            color: Colors.black45, fontWeight: FontWeight.w500), // Estilo de la etiqueta
      ),
    );
  }
}
