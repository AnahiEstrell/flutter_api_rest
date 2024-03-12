import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';

// Widget para el formulario de registro
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

// Estado del formulario de registro
class _RegisterFormState extends State<RegisterForm> {
  // Clave global para el formulario
  GlobalKey<FormState> _formKey = GlobalKey();
  // Variables para almacenar el correo electrónico, contraseña y nombre de usuario
  String _email = '', _password = '', _username = '';
  // Instancias de la API de autenticación y cliente de autenticación
  final authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  // Instancia del logger para registrar eventos

  // Método para enviar el formulario
  Future<void> _submit() async {
    // Validar el formulario
    final isOk = _formKey.currentState?.validate() ?? false;
    if (isOk) {
      // Mostrar el diálogo de progreso
      ProgressDialog.show(context);
      // Realizar la solicitud de registro a la API de autenticación
      final response = await authenticationApi.register(
        username: _username,
        email: _email,
        password: _password,
      );
      // Ocultar el diálogo de progreso
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        // Guardar la sesión del usuario si la respuesta es exitosa
        await _authenticationClient.saveSession(response.data!);
        // Navegar a la pantalla de inicio y eliminar todas las rutas anteriores
        Navigator.pushNamedAndRemoveUntil(
            context, Home.routeName, (_) => false);
      } else {
        // Mostrar un mensaje de error en caso de que falle el registro
        String message = "";
        if (response.error?.statusCode == -1) {
          message = "Bad network";
        } else if (response.error?.statusCode == 409) {
          message =
              "Duplicated user ${jsonEncode(response.error?.data['duplicatedFields'])}";
        }
        Dialogs.alert(context, title: "Error", description: message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener la instancia de Responsive
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: responsive.isTablet
                ? 430
                : 360), // Límite de ancho del contenedor
        child: Form(
          key: _formKey, // Asignar la clave global al formulario
          child: Column(
            children: <Widget>[
              // Campo de entrada de texto para el nombre de usuario
              InputText(
                keyBoardType: TextInputType.emailAddress,
                label: "USERNAME",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _username = text; // Actualizar el valor del nombre de usuario
                },
                validator: (text) {
                  // Validar el nombre de usuario
                  if (text!.trim().length < 5) {
                    return "Invalid username";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)), // Espaciador
              // Campo de entrada de texto para el correo electrónico
              InputText(
                keyBoardType: TextInputType.emailAddress,
                label: "EMAIL ADDRESS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text; // Actualizar el valor del correo electrónico
                },
                validator: (text) {
                  // Validar el correo electrónico
                  if (!text!.contains("@")) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)), // Espaciador
              // Campo de entrada de texto para la contraseña
              InputText(
                obscureText: true,
                keyBoardType: TextInputType.emailAddress,
                label: "PASSWORD",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _password = text; // Actualizar el valor de la contraseña
                },
                validator: (text) {
                  // Validar la contraseña
                  if (text!.trim().length < 5) {
                    return "Invalid password";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(5)), // Espaciador
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit, // Método de envío del formulario
                  child: Text(
                    "Sign up", // Texto del botón
                    style: TextStyle(
                        color: Colors.white, // Color del texto
                        fontSize: responsive.dp(1.5)), // Tamaño de fuente
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Ajustes del botón
                    backgroundColor:
                        Colors.redAccent, // Color de fondo del botón
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(0), // Bordes rectos del botón
                    ),
                  ),
                ),
              ),
              SizedBox(height: responsive.dp(2)), // Espaciador
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Texto para la opción de inicio de sesión
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: responsive.dp(1.5)),
                  ),
                  // Botón para volver a la pantalla de inicio de sesión
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign in", // Texto del botón
                        style: TextStyle(
                            color: Colors.redAccent, // Color del texto
                            fontSize: responsive.dp(1.5)), // Tamaño de fuente
                      ))
                ],
              ),
              SizedBox(height: responsive.dp(10)), // Espaciador
            ],
          ),
        ),
      ),
    );
  }
}
