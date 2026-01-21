part of catapiljaapp;

abstract class HttpRequestHandler {
  bool canHandle(HttpRequest request);
  Future<void> handle(HttpRequest request);
  dynamic handleRequestMethod({
    required HttpRequest httpRequest,
    required Map<String, String> parameters,
  });
}
