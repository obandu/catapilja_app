part of catapiljaapp;

class CloudApp {
  final Router _router;
  final String _applicationName;
  final String _registrationURL;
  static bool _isRegistered = false;

  CloudApp({
    required Router router,
    required String applicationName,
    required String registrationURL,
  }) : _router = router,
       _applicationName = applicationName,
       _registrationURL = registrationURL;

  Future<void> start(InternetAddress address, int port) async {
    var server = await HttpServer.bind(address, port);
    ServerLog.doServerLog(
      "At $_applicationName.cloudapp.start(): server started and waiting for requests",
    );
    runRegistrationRequest();
    await for (var request in server) {
      _router.route(request);
    }
  }

  static void setIsRegistered(bool value) {
    _isRegistered = value;
  }

  void runRegistrationRequest() {
    // add a polling function here that calls another server every 1 minute
    String _myname = Platform.environment['MYNAME'].toString();
    String _applicationPort = Platform.environment['APPLICATIONPORT']
        .toString();
    Map<String, String> headers = const {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (_isRegistered) {
        ServerLog.doServerLog(
          "At $_myname.cloudapp.runRegistrationRequest(): No further registration calls needed.",
        );
        timer.cancel();
        return;
      }
      ServerLog.doServerLog(
        "At $_myname.cloudapp.runRegistrationRequest(): $timer.tick",
      );
      ServerLog.doServerLog(
        "At $_myname.cloudapp.runRegistrationRequest(): FROM $_applicationName: Another call to register the server. Registration status is $_isRegistered",
      );
      try {
        final response = await httpClient.post(
          Uri.parse(_registrationURL),
          body: {
            "action": "registerme",
            "application_name": _myname,
            "application_port": _applicationPort,
            "access_protocol": "HTTP_POST",
            "registration_url": _myname,
            "application_url": _myname,
            "registrationapi_path": "handshake",
          },
          headers: headers,
        );
        ServerLog.doServerLog(
          "At $_myname.cloudapp.runRegistrationRequest(): $_applicationName: registration response: ${response.body}",
        );
      } catch (e) {
        ServerLog.doServerLog(
          "At $_myname.cloudapp.runRegistrationRequest(): $_applicationName:Error during call for application registration: $e",
        );
      }
    });
  }
}
