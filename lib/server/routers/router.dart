part of catapiljaapp;

class Router {
  final List<HttpRequestHandler> _handlers;

  Router(this._handlers);

  Future<void> route(HttpRequest request) async {
    // Set CORS headers
    if (request.headers.value('Origin') != null) {
      request.response.headers.set(
        'Access-Control-Allow-Origin',
        request.headers.value('Origin')!,
      );
    }

    request.response.headers.set(
      'Access-Control-Allow-Methods',
      'POST, GET, OPTIONS',
    );
    request.response.headers.set(
      'Access-Control-Allow-Headers',
      'Content-Type',
    );
    request.response.headers.set('Access-Control-Allow-Credentials', 'true');
    request.response.headers.set(
      'Access-Control-Allow-Headers',
      'Origin, Content-Type, Accept',
    );

    // Handle preflight requests
    if (request.method == 'OPTIONS') {
      request.response.close();
      return;
    }

    for (var handler in _handlers) {
      if (handler.canHandle(request)) {
        return handler.handle(request);
      }
    }
    request.response
      ..statusCode = HttpStatus.methodNotAllowed
      ..write("{\"httpmethod\" : \"${request.headers}\"}")
      ..close();
  }
}
