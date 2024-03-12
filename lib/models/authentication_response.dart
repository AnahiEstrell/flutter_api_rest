// Importa el paquete 'dart:convert' para trabajar con JSON.
import 'dart:convert';

// Define una función 'authenticationResponseFromJson' para convertir una cadena JSON en una instancia de 'AuthenticationResponse'.
AuthenticationResponse authenticationResponseFromJson(String str) =>
    AuthenticationResponse.fromJson(json.decode(str));

// Define una función 'authenticationResponseToJson' para convertir una instancia de 'AuthenticationResponse' en una cadena JSON.
String authenticationResponseToJson(AuthenticationResponse data) =>
    json.encode(data.toJson());

// Define la clase 'AuthenticationResponse' para representar la respuesta de autenticación.
class AuthenticationResponse {
  // Declara las propiedades 'token' y 'expiresIn'.
  String token;
  int expiresIn;

  // Define el constructor 'AuthenticationResponse' que toma el token y el tiempo de expiración como argumentos.
  AuthenticationResponse({
    required this.token,
    required this.expiresIn,
  });

  // Define un método de fábrica 'fromJson' para crear una instancia de 'AuthenticationResponse' a partir de un mapa JSON.
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponse(
        token: json[
            "token"], // Asigna el valor del token del mapa JSON a la propiedad 'token'.
        expiresIn: json[
            "expiresIn"], // Asigna el valor del tiempo de expiración del mapa JSON a la propiedad 'expiresIn'.
      );

  // Define un método 'toJson' para convertir una instancia de 'AuthenticationResponse' en un mapa JSON.
  Map<String, dynamic> toJson() => {
        "token":
            token, // Agrega la propiedad 'token' al mapa JSON con la clave "token".
        "expiresIn":
            expiresIn, // Agrega la propiedad 'expiresIn' al mapa JSON con la clave "expiresIn".
      };
}
