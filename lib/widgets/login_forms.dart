
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';

// Widget para el formulario de inicio de sesión
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

// Estado del formulario de inicio de sesión
class _LoginFormState extends State<LoginForm> {
  // Clave global para el formulario
  final GlobalKey<FormState> _formKey = GlobalKey();
  // Variables para almacenar el correo electrónico y la contraseña
  String _email = '', _password = '';
  // Instancias de la API de autenticación y cliente de autenticación
  final authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  // Método para enviar el formulario
  Future<void> _submit() async {
    // Validar el formulario
    final isOk = _formKey.currentState?.validate() ?? false;
    if (isOk) {
      // Mostrar el diálogo de progreso
      ProgressDialog.show(context);
      // Realizar la solicitud de inicio de sesión a la API de autenticación
      final response =
          await authenticationApi.login(email: _email, password: _password);
      // Ocultar el diálogo de progreso
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        // Guardar la sesión del usuario si la respuesta es exitosa
        await _authenticationClient.saveSession(response.data!);
        // Navegar a la pantalla de inicio y eliminar todas las rutas anteriores
        Navigator.pushNamedAndRemoveUntil(
            context, Home.routeName, (_) => false);
      } else {
        // Mostrar un mensaje de error en caso de que falle la autenticación
        String message = "";
        if (response.error?.statusCode == -1) {
          message = "Bad network";
        } else if (response.error?.statusCode == 403) {
          message = "Invalid password";
        } else if (response.error?.statusCode == 404) {
          message = "User not found";
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
              SizedBox(height: responsive.dp(2)),
              // Contenedor para la entrada de texto de la contraseña
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Row(
                  children: [
                    Expanded(
                      child: InputText(
                        label: "PASSWORD",
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                        obscureText: true,
                        borderEnabled: false,
                        onChanged: (text) {
                          _password =
                              text; // Actualizar el valor de la contraseña
                        },
                        validator: (text) {
                          // Validar la contraseña
                          if (text?.trim().length == 0) {
                            return "Invalid password";
                          }
                          return null;
                        },
                      ),
                    ),
                    // Botón para recuperar la contraseña
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10)), // Ajustes del botón
                        onPressed: () {},
                        child: Text(
                          "Forgot Passwrod",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: responsive
                                  .dp(responsive.isTablet ? 1.2 : 1.5)),
                        )),
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(5)), // Espaciador
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit, // Método de envío del formulario
                  child: Text(
                    "Sign in", // Texto del botón
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
                  // Texto para la opción de registro
                  Text(
                    "New to Friendly Desi?",
                    style: TextStyle(fontSize: responsive.dp(1.5)),
                  ),
                  // Botón para ir a la pantalla de registro
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: Text(
                        "Sign up", // Texto del botón
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
