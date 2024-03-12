import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_api_rest/helpers/http_response.dart';
import 'package:flutter_api_rest/models/authentication_response.dart';

class AuthenticationApi {
  // Una clase para manejar las operaciones de autenticación en la API.

  final Http _http;
  // Una instancia de la clase `Http` para realizar solicitudes HTTP.

  // Constructor que inicializa la API de autenticación con una instancia de `Http`.
  AuthenticationApi({required Http http}) : _http = http;

  // Método para registrar un nuevo usuario.
  Future<HttpResponse<AuthenticationResponse>> register({
    required String username,
    required String email,
    required String password,
  }) {
    // Realiza una solicitud POST para registrar un nuevo usuario.
    return _http.request<AuthenticationResponse>('/api/v1/register',
        method: "POST",
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
        // Parsea los datos de la respuesta JSON a un objeto `AuthenticationResponse`.
        parser: (data) {
      return AuthenticationResponse.fromJson(data);
    });
  }

  // Método para iniciar sesión.
  Future<HttpResponse<AuthenticationResponse>> login({
    required String email,
    required String password,
  }) {
    // Realiza una solicitud POST para iniciar sesión.
    return _http.request<AuthenticationResponse>('/api/v1/login',
        method: "POST",
        data: {
          "email": email,
          "password": password,
        },
        // Parsea los datos de la respuesta JSON a un objeto `AuthenticationResponse`.
        parser: (data) {
      return AuthenticationResponse.fromJson(data);
    });
  }

  // Método para obtener un nuevo token de acceso a partir de un token caducado.
  Future<HttpResponse<AuthenticationResponse>> refreshToken({
    required String expiredToken,
  }) {
    // Realiza una solicitud POST para obtener un nuevo token de acceso.
    return _http.request<AuthenticationResponse>('/api/v1/refresh-token',
        method: "POST",
        headers: {
          "token": expiredToken,
        },
        // Parsea los datos de la respuesta JSON a un objeto `AuthenticationResponse`.
        parser: (data) {
      return AuthenticationResponse.fromJson(data);
    });
  }
}
