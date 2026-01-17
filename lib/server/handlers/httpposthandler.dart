part of catapiljaapp;

class HttpPostHandler implements HttpRequestHandler {
  @override
  bool canHandle(HttpRequest req) => req.method == 'POST';

  @override
  Future<void> handle(HttpRequest req) async {
    String _myApplicationName = Platform.environment['MYNAME'].toString();
    try {
      // 1. Decode the byte stream into a single String.
      utf8.decodeStream(req).then((requestBody) {
        // 2. Parse the query-string into a Map<String, String>.
        final Map<String, String> params = Uri.splitQueryString(requestBody);

        ServerLog.doServerLog(
          'At $_myApplicationName.HttpPostHandler.handle(): Params sent to application@post: $params',
        );

        String postResponse = jsonEncode(
          handleRequestMethod(req.uri.toString(), params),
        ).toString();

        ServerLog.doServerLog(
          "At $_myApplicationName.HttpPostHandler.handle(): The post response from ${req.uri.toString()} is $postResponse",
        );

        req.response.statusCode = HttpStatus.ok;
        req.response.headers.contentType = ContentType("application", "json");
        req.response.write(postResponse);
        req.response.close();
      });
    } catch (ex) {
      String errorString =
          "Error at At $_myApplicationName.HttpPostHandler.handle(): HTTP POST Request: ${req.uri} $ex!";
      ServerLog.doServerLog(errorString);
      req.response.write(
        {"status": "error", "message": errorString}.toString(),
      );
      req.response.close();
    }
  }

  dynamic handleRequestMethod(
    String requestName,
    Map<String, String> parameters,
  ) {
    String _myname = Platform.environment['MYNAME'].toString();
    ServerLog.doServerLog(
      "At $_myname.HttpPostHandler.handleMethodRequest():, we are here ... with $requestName and params ${parameters.toString()}",
    );

    if (requestName == "/api") {
      String action = parameters['action'].toString();
      switch (action) {
        case "ping":
          return {"status": HttpStatus.ok, "ping": "pong"};
        case "init":
          return {"status": HttpStatus.ok, "ping": "pong"};
        case "workbenchinitdata":
          return {"status": HttpStatus.ok, "message": "Init data requested"};
        default:
      }
      return {"status": "ok"};
    }
    if (requestName == "/handshake") {
      return {
        "status": "ok",
        "application": _myname,
        "confirmationapi_path": "confirmregistration",
      };
    }
    if (requestName == "/confirmregistration") {
      CloudApp.setIsRegistered(true);
      return {"status": "ok", "message": "ready to work and thank you"};
    }
    if (requestName == "/catapiljacloudcall") {
      return {
        "status": "ok",
        "application": _myname,
        "message": "you made a catapiljacloudcall",
      };
    }
    return {
      "status": HttpStatus.notFound,
      "message": "Request $requestName is not handled by $_myname",
    };
  }
}
