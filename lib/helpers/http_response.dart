class HttpResponse<T> { // Define una clase genérica llamada `HttpResponse`, donde `T` representa el tipo de datos que se espera recibir en la respuesta.

  // Declara dos propiedades: `data`, que contiene los datos de la respuesta, y `error`, que representa cualquier error que ocurra durante la solicitud. Ambas pueden ser nulas.
  final T? data;
  final HttpError? error;

  // Define un constructor que inicializa las propiedades `data` y `error` de la clase `HttpResponse`.
  HttpResponse({required this.data, required this.error});

  // Define un método estático llamado `success`, que devuelve una instancia de `HttpResponse` con los datos proporcionados y sin errores.
  static HttpResponse<T> success<T>(T data) =>
      HttpResponse(data: data, error: null);

  
  // Define un método estático llamado `fail`, que devuelve una instancia de `HttpResponse` con `data` como nulo y un objeto `HttpError` que contiene la información del error, como el código de estado, el mensaje y cualquier dato adicional relacionado con el error.
  static HttpResponse<T> fail<T>({
    required int statusCode,
    required String message,
    dynamic data,
  }) =>
      HttpResponse(
          data: null,
          error:
              HttpError(statusCode: statusCode, message: message, data: data));
}

class HttpError { // Define una clase llamada `HttpError`.

  // Declara tres propiedades: `statusCode` para almacenar el código de estado HTTP del error, `message` para el mensaje de error y `data` para cualquier dato adicional relacionado con el error.
  final int statusCode;
  final String message;
  final dynamic data;

  HttpError(
     // Define un constructor que inicializa las propiedades `statusCode`, `message` y `data` de la clase `HttpError`.
      {required this.statusCode, required this.message, required this.data});
}
