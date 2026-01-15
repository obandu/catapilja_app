part of catapiljaapp;

abstract class HttpRequestHandler {
  bool canHandle(HttpRequest request);
  Future<void> handle(HttpRequest request);
}
