part of catapiljaapp;

class HttpGetResourceNotFoundError {
  static void respondToPageNotFoundError(HttpRequest req, String furtherInfo) {
    String notFoundPath = req.uri.toString();

    ServerLog.doServerLog(
      "Requested resource $notFoundPath is requested but not found. Further info: $furtherInfo",
    );

    req.response.statusCode = HttpStatus.notFound;
    req.response.headers.contentType = ContentType("text", "html");

    final File error404File = File(
      "${OSContainer.website}/webface/error404.html",
    );
    error404File.exists().then((bool fileExists) {
      if (fileExists) {
        error404File.readAsString().then((content) {
          String newContent = content.replaceAll(
            "**errormessage",
            "Requested resource $notFoundPath is requested but not found. Further info: $furtherInfo",
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
        ServerLog.doServerLog("Error 404 File $error404File is served");
      } else {
        ServerLog.doServerLog("Error 404 File $error404File is not found");
        req.response.write(
          'You made a request for the error 404 page but the files doesn\'t exist. Please contact developer',
        );
        req.response.close();
      }
    });
  }
}
