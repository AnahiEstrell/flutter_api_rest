import 'package:dio/dio.dart';
import 'package:flutter_api_rest/helpers/http_response.dart';
import 'package:flutter_api_rest/utils/utils.dart';

  // Define una clase llamada `Http` para manejar las solicitudes HTTP.
class Http {
  
  // Declara una propiedad privada `_dio` de tipo `Dio`.
  final Dio _dio;

  // Define un constructor que recibe un booleano `logsEnabled` y una instancia de `Dio` como parámetros. Inicializa la propiedad `_dio` con la instancia proporcionada.
  Http({required bool logsEnabled, required Dio dio}) : _dio = dio;

  // Define un método `request` que realiza una solicitud HTTP y devuelve un objeto `Future` de tipo `HttpResponse`.
  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, String>? headers,
    T Function(dynamic data)? parser,
  }) async {
    
    // Intenta realizar la solicitud HTTP.
    try {
      // Simula un retraso de 2 segundos para representar una solicitud asíncrona.
      await Future.delayed(const Duration(seconds: 2));

      // Realiza la solicitud HTTP usando la instancia de `Dio` y espera la respuesta.
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: formData != null ? FormData.fromMap(formData) : data,
      );

      // Registra los datos de la respuesta en los registros de la aplicación.
      Logs.p.i(response.data);

      // Si se proporciona un `parser`, aplica la función de análisis a los datos de la respuesta.
      if (parser != null) {
        return HttpResponse.success<T>(parser(response.data));
      }

      // Devuelve una respuesta exitosa con los datos de la respuesta.
      return HttpResponse.success<T>(response.data);

    } catch (e) {
      // Maneja cualquier error que ocurra durante la solicitud.

      // Registra el error en los registros de la aplicación.
      Logs.p.e(e);

      // Define un mensaje predeterminado
      String message = "unknown error";

      // Define una variable para almacenar el código de estado HTTP del error
      int? statusCode = 0;

      // Define una variable para almacenar datos adicionales relacionados con el error
      dynamic data;

      // Si el error es de tipo `DioError`, extrae la información relevante.
      // ignore: deprecated_member_use
      if (e is DioError) {
        statusCode = -1;
        message = e.message ?? "unknown error";

        if (e.response != null) {
          statusCode = e.response!.statusCode;
          message = e.response!.statusMessage ?? "unknown error";
          data = e.response!.data;
        }
      }

      // Devuelve una respuesta de error con la información relevante.
      return HttpResponse.fail<T>(
        statusCode: statusCode ?? -1,
        message: message,
        data: data
      );
    }
  }
}

