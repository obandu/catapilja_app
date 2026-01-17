part of catapiljaapp;

class HttpGetHandler implements HttpRequestHandler {
  @override
  bool canHandle(HttpRequest req) => req.method == 'GET';

  @override
  Future<void> handle(HttpRequest req) async {
    String uri = req.uri.toString();

    try {
      // Update or create a user session for the request
      // req = Sessionhandler.createCatapiljaCloudSessionIfDoesNotExist(req);
      // print("So far here ... ${req.cookies}");

      /* final File homePageFile = File('./app/webface/index.html');
      homePageFile.exists().then((bool fileExists) {
        if (fileExists) {
          req.response.headers.contentType = ContentType("text", "html");
          homePageFile.readAsString().then((content) {
            String newContent = content.replaceAll(
              "window.location.hostname",
              "\"localhost:8080\"",
            );
            newContent = newContent.replaceAll(
              "<base href=\"/\">",
              "  <base href=\"./app/webface/\">",
            );
            newContent = newContent.replaceAll(
              "window.location.protocol",
              "\"http:\"",
            );

            req.response.write(newContent);
            req.response.close();
          });
          ServerLog.doServerLog("Home page File $homePageFile is served");
        } else {
          HttpGetResourceNotFoundError.respondToPageNotFoundError(
            req,
            "Home page file not found",
          );
        }
      }); */

      String _myname = Platform.environment['MYNAME'].toString();

      handleRequestMethod(req.uri.toString(), {}).then((getResponse) {
        ServerLog.doServerLog(
          "At $_myname.HttpGetHandler.handle(): The get response from ${req.uri.toString()} is $getResponse",
        );

        req.response.statusCode = HttpStatus.ok;
        req.response.headers.contentType = ContentType("application", "json");
        req.response.write(getResponse);
        req.response.close();
      });
    } catch (ex) {
      ServerLog.doServerLog("Error at HTTP Request: URI '$uri' $ex!");
      req.response.write("Error at HTTP Request: URI '$uri' $ex!");
      req.response.close();
    }
  }

  Future<String?> handleRequestMethod(
    String requestName,
    Map<String, String> parameters,
  ) async {
    String _myname = Platform.environment['MYNAME'].toString();
    return "{'status' : 'no implementation','message' : 'At $_myname.HttpGetHandler.handleMethodRequest():, we are here ... with $requestName and params ${parameters.toString()}'}";
  }
}
