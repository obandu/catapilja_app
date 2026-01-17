part of catapiljaapp;

abstract class HttpRequestHandler {
  bool canHandle(HttpRequest request);
  Future<void> handle(HttpRequest request);
  dynamic handleRequestMethod(
    String requestName,
    Map<String, String> parameters,
  );
}
